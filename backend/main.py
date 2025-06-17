# heymachi_backend/main.py

from dotenv import load_dotenv
load_dotenv()
import sys
import os

 
sys.path.append('/Users/bala/development/AppDev/hm_industries')
from hm_industries.restaurant.backend.dbmodels import OpenOrderDB


from datetime import timedelta
from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session

from database import get_db, engine, SessionLocal
from models.base import Base
from models.user import User
from utils.id_generator import generate_custom_id

from routers import (
    users, roles, category, subcategory, product, tax, customer, vendor,
    unit, billing, payment_type, transaction, email, business_profile,
    branch, promotion, business_account, industry_router
)

from routers.auth import (
    router as auth_router,
    authenticate_user,
    create_access_token,
    get_current_user
)

from schemas.user import UserCreate, UserOut
from schemas.auth import Token

from seeder.industry_seeder import seed_industries
from seeder.business_account_seeder import seed_business_accounts

# Restaurant module
from restaurant.backend.routers import open_order_router
from restaurant.backend.models import open_order_model



# ────────────────────────────────────────────────────────────────────────────────
app = FastAPI(title="HeyMachi Backend")

# ─── CORS Setup ─────────────────────────────────────────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Replace with actual origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ─── Startup DB setup ───────────────────────────────────────────────────────────
@app.on_event("startup")
def startup_event():
    Base.metadata.create_all(bind=engine)
    print("All tables seen by metadata:", Base.metadata.tables.keys())  # 👈
    db = SessionLocal()
    seed_industries(db)  
    seed_business_accounts(db)
    db.close()

ACCESS_TOKEN_EXPIRE_MINUTES = 60


# ─── Auth Endpoints ─────────────────────────────────────────────────────────────
@app.post("/register", response_model=UserOut, tags=["auth"])
def register_user(user_in: UserCreate, db: Session = Depends(get_db)):
    return users.create_user(user_in, db)

@app.post("/auth/token", response_model=Token, tags=["auth"])
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect username or password")

    access_token = create_access_token(
        data={"sub": user.username},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/auth/me", response_model=UserOut, tags=["auth"])
def read_users_me(current_user: User = Depends(get_current_user)):
    return current_user


# ─── API Routers ────────────────────────────────────────────────────────────────
app.include_router(business_account)
app.include_router(industry_router)

app.include_router(users)
app.include_router(roles)
app.include_router(category)
app.include_router(subcategory)
app.include_router(product, prefix="/products", tags=["Products"])
app.include_router(tax)
app.include_router(customer)
app.include_router(vendor)
app.include_router(unit)
app.include_router(billing)
app.include_router(payment_type)
app.include_router(transaction)
app.include_router(email)
app.include_router(business_profile)
app.include_router(promotion)
app.include_router(branch)

# Plug-in restaurant module
try:
    app.include_router(open_order_router)
except ImportError:
    print("Restaurant module not available")
    
#app.include_router(open_order.router, prefix="/restaurant/open-orders", tags=["Restaurant Orders"])

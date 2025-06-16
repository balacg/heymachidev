# heymachi_backend/main.py
from dotenv import load_dotenv
load_dotenv()

from datetime import timedelta

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from utils.id_generator import generate_custom_id

from database import get_db, engine, SessionLocal
from models import Base
from models.user import User

from routers import industry_router
from routers import business_account

from routers import users, roles, category, subcategory, product, tax, customer, vendor, unit, billing, payment_type, transaction, email, business_profile, branch, promotion
from routers.auth import router as auth_router, authenticate_user, create_access_token, get_current_user

from schemas.user import UserCreate, UserOut
from schemas.auth import Token

from seeder.industry_seeder import seed_industries
from seeder.business_account_seeder import seed_business_accounts

app = FastAPI(title="HeyMachi Backend")


# ────────────────────────────────────────────────────────────────────────────────

# ── CORS ────────────────────────────────────────────────────────────────────────
# Allow your Flutter/web frontends to call this API during development.
# In production, replace ["*"] with your real origins (e.g. ["https://your.domain"])
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],            # or ["http://localhost:3000", "http://10.0.2.2:8000"]
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Create all tables
@app.on_event("startup")

def startup_event():
    Base.metadata.create_all(bind=engine)
    db = SessionLocal()
    seed_business_accounts(db)
    db.close()

ACCESS_TOKEN_EXPIRE_MINUTES = 60


# --- Authentication endpoints ---------------------------------------------
@app.post("/register", response_model=UserOut, tags=["auth"])
def register_user(user_in: UserCreate, db: Session = Depends(get_db)):
    return users.create_user(user_in, db)


@app.post("/auth/token", tags=["auth"], response_model=Token)
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = authenticate_user(db, form_data.username, form_data.password)
    if not user or user is False:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password"
        )

    access_token = create_access_token(
        data={"sub": user.username},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )

    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/auth/me", tags=["auth"], response_model=UserOut)
def read_users_me(current_user: User = Depends(get_current_user)):
    return current_user


# --- Include all your routers --------------------------------------------

app.include_router(business_account)  # /business-accounts
app.include_router(industry_router)


app.include_router(users)      # /users
app.include_router(roles)      # /roles
app.include_router(category)   # /category
app.include_router(subcategory)# /subcategory
app.include_router(product, prefix="/products", tags=["Products"])    # /product
app.include_router(tax)        # /tax
app.include_router(customer)   # /customer
app.include_router(vendor)     # /vendor
app.include_router(unit)       # /unit
app.include_router(billing)    # /billing
app.include_router(payment_type)   # /payment_types
app.include_router(transaction)   # /transactions
app.include_router(email)   # /email
app.include_router(business_profile)
app.include_router(promotion)
app.include_router(branch)

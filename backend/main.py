# heymachi_backend/main.py

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from sqlalchemy.orm import Session

from database import get_db, engine
from models import Base
from models.user import User
from routers import users, roles, category, subcategory, product, tax, customer, vendor, unit, billing
from routers.auth import router as auth_router, get_current_user
from schemas.user import UserCreate, UserOut
from schemas.auth import Token

app = FastAPI(title="HeyMachi Backend")

Base.metadata.create_all(bind=engine)

ACCESS_TOKEN_EXPIRE_MINUTES = 60

@app.post("/register", response_model=UserOut, tags=["auth"])
def register_user(user_in: UserCreate, db: Session = Depends(get_db)):
    return users.create_user(user_in, db)

@app.post("/token", tags=["auth"], response_model=Token)
def login(form_data: OAuth2PasswordRequestForm = Depends(), db: Session = Depends(get_db)):
    user = auth_router.authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Incorrect username or password")
    access_token = auth_router.create_access_token(
        data={"sub": user.username},
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )
    return {"access_token": access_token, "token_type": "bearer"}

@app.get("/me", tags=["users"], response_model=UserOut)
def read_users_me(current_user: User = Depends(get_current_user)):
    return current_user

# Include routers
app.include_router(users)
app.include_router(roles)
app.include_router(auth_router)
app.include_router(category)
app.include_router(subcategory)
app.include_router(product)
app.include_router(tax)
app.include_router(customer)
app.include_router(vendor)
app.include_router(unit)
app.include_router(billing)
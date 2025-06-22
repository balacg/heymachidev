# heymachi_backend/routers/auth.py

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from datetime import timedelta
from sqlalchemy.orm import Session
from database import get_db
from core.security import UserSession, authenticate_user, create_access_token, get_current_user
from schemas.auth import Token
from models.user import User

router = APIRouter(prefix="/auth", tags=["auth"]) 

ACCESS_TOKEN_EXPIRE_MINUTES = 60

@router.post("/token", response_model=Token)
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):
    user: User = authenticate_user(db, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password"
        )

    access_token = create_access_token(
        data={
            "sub": user.username,
            "user_id": user.id,
            "email": user.email,
            "business_id": user.business_id,
            "is_admin": user.is_admin
        },
        expires_delta=timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES),
    )
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "business_id": user.business_id,
        "user_id": user.id,
        "role": "admin" if user.is_admin else "user"
    }

@router.get("/me", response_model=UserSession)
def read_users_me(current_user: User = Depends(get_current_user)):
    print("Returning user:", current_user.username, current_user.business_id)

    return UserSession(
        username=current_user.username,
        email=current_user.email,
        user_id=current_user.id,
        business_id=current_user.business_id,
        is_admin=current_user.is_admin
    )

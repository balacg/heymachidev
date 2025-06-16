from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.user import User
from schemas.user import UserCreate, UserOut, UserUpdate
from routers.auth import get_current_user

router = APIRouter(prefix="/users", tags=["users"])

# ✅ Get users for the same business only
@router.get("/", response_model=List[UserOut])
def get_users(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(User).filter_by(business_id=current_user.business_id).all()

# ✅ Create user under same business_id as current_user
@router.post("/", response_model=UserOut)
def create_user(
    user_in: UserCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    existing = db.query(User).filter(User.username == user_in.username).first()
    if existing:
        raise HTTPException(status_code=400, detail="Username already exists")

    new_user = User(**user_in.dict())
    new_user.business_id = current_user.business_id  # 🔐 Scoped
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

# ✅ Update user (optional enhancement — could limit update only to own business' users)
@router.put("/{user_id}", response_model=UserOut)
def update_user(
    user_id: str,
    user_in: UserUpdate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    user = db.query(User).filter(User.id == user_id).first()
    if not user or user.business_id != current_user.business_id:
        raise HTTPException(status_code=404, detail="User not found or unauthorized")
    
    for field, value in user_in.dict(exclude_unset=True).items():
        setattr(user, field, value)

    db.commit()
    db.refresh(user)
    return user

# ✅ Delete user — Scoped by business
@router.delete("/{user_id}", status_code=204)
def delete_user(
    user_id: str,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    user = db.query(User).filter(User.id == user_id).first()
    if not user or user.business_id != current_user.business_id:
        raise HTTPException(status_code=404, detail="User not found or unauthorized")
    db.delete(user)
    db.commit()

# heymachi/backend/routers/category.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.category import Category
from schemas.category import CategoryCreate, CategoryOut
from routers.auth import get_current_user
from models.user import User
from utils.id_generator import generate_custom_id

router = APIRouter(prefix="/categories", tags=["categories"])

@router.get("/", response_model=List[CategoryOut])
def get_categories(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Category).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=CategoryOut)
def create_category(category_in: CategoryCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    # Check for duplicate name within business
    existing = db.query(Category).filter_by(name=category_in.name, business_id=current_user.business_id).first()
    if existing:
        raise HTTPException(status_code=409, detail="Category already exists")

    category = Category(id=generate_custom_id("CAT", db, Category), **category_in.dict())
    category.business_id = current_user.business_id 
    db.add(category)
    db.commit()
    db.refresh(category)
    return category


# ─── NEW: Update ──────────────────────────────────────────────
@router.put("/{category_id}", response_model=CategoryOut)
def update_category(
    category_id: str,
    payload: CategoryCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    cat = db.query(Category).filter(Category.id == category_id).first()
    if not cat:
        raise HTTPException(status_code=404, detail="Category not found")

    # Check for duplicate name (excluding self)
    existing = db.query(Category).filter(
        Category.name == payload.name,
        Category.business_id == current_user.business_id,
        Category.id != category_id
    ).first()
    if existing:
        raise HTTPException(status_code=409, detail="Category name already exists")

    cat.name   = payload.name
    cat.gst_id = payload.gst_id
    db.commit()
    db.refresh(cat)
    return cat


# ─── NEW: Delete ──────────────────────────────────────────────
@router.delete("/{category_id}", status_code=204)
def delete_category(category_id: str, db: Session = Depends(get_db)):
    cat = db.query(Category).filter(Category.id == category_id).first()
    if not cat:
        raise HTTPException(status_code=404, detail="Category not found")
    db.delete(cat)
    db.commit()


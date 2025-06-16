# heymachi/backend/routers/subcategory.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.subcategory import Subcategory
from schemas.subcategory import SubcategoryCreate, SubcategoryOut
from routers.auth import get_current_user
from models.user import User
from utils.id_generator import generate_custom_id

router = APIRouter(prefix="/subcategories", tags=["subcategories"])

@router.get("/", response_model=List[SubcategoryOut])
def get_subcategories(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(Subcategory).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=SubcategoryOut)
def create_subcategory(
    payload: SubcategoryCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # Check for duplicate subcategory name under same category
    existing = db.query(Subcategory).filter_by(
        name=payload.name,
        category_id=payload.category_id,
        business_id=current_user.business_id
    ).first()
    if existing:
        raise HTTPException(status_code=409, detail="Subcategory already exists under this category")

    new_item = Subcategory(
        id=generate_custom_id("SCAT",db, Subcategory), 
        **payload.dict())
    new_item.business_id = current_user.business_id
    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    return new_item


# ─── NEW: Update ──────────────────────────────────────────────
@router.put("/{subcategory_id}", response_model=SubcategoryOut)
def update_subcategory(
    subcategory_id: str,
    payload: SubcategoryCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    sub = db.query(Subcategory).filter(Subcategory.id == subcategory_id).first()
    if not sub:
        raise HTTPException(status_code=404, detail="Subcategory not found")

    # Check for duplicate name under same category (excluding self)
    existing = db.query(Subcategory).filter(
        Subcategory.name == payload.name,
        Subcategory.category_id == payload.category_id,
        Subcategory.business_id == current_user.business_id,
        Subcategory.id != subcategory_id
    ).first()
    if existing:
        raise HTTPException(status_code=409, detail="Subcategory already exists under this category")

    sub.name        = payload.name
    sub.category_id = payload.category_id
    sub.gst_id      = payload.gst_id
    db.commit()
    db.refresh(sub)
    return sub


# ─── NEW: Delete ──────────────────────────────────────────────
@router.delete("/{subcategory_id}", status_code=204)
def delete_subcategory(subcategory_id: str, db: Session = Depends(get_db)):
    sub = db.query(Subcategory).filter(Subcategory.id == subcategory_id).first()
    if not sub:
        raise HTTPException(status_code=404, detail="Subcategory not found")
    db.delete(sub)
    db.commit()

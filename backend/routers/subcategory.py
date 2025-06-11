# heymachi/backend/routers/subcategory.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.subcategory import Subcategory
from schemas.subcategory import SubcategoryCreate, SubcategoryOut

router = APIRouter(prefix="/subcategories", tags=["subcategories"])

@router.get("/", response_model=List[SubcategoryOut])
def read_subcategories(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(Subcategory).offset(skip).limit(limit).all()

@router.post("/", response_model=SubcategoryOut)
def create_subcategory(subcategory: SubcategoryCreate, db: Session = Depends(get_db)):
    db_sub = Subcategory(
        name=subcategory.name,
        category_id=subcategory.category_id,
        gst_id=subcategory.gst_id,
    )
    db.add(db_sub)
    db.commit()
    db.refresh(db_sub)
    return db_sub

# ─── NEW: Update ──────────────────────────────────────────────
@router.put("/{subcategory_id}", response_model=SubcategoryOut)
def update_subcategory(
    subcategory_id: int,
    payload: SubcategoryCreate,
    db: Session = Depends(get_db),
):
    sub = db.query(Subcategory).filter(Subcategory.id == subcategory_id).first()
    if not sub:
        raise HTTPException(status_code=404, detail="Subcategory not found")
    sub.name        = payload.name
    sub.category_id = payload.category_id
    sub.gst_id      = payload.gst_id
    db.commit()
    db.refresh(sub)
    return sub

# ─── NEW: Delete ──────────────────────────────────────────────
@router.delete("/{subcategory_id}", status_code=204)
def delete_subcategory(subcategory_id: int, db: Session = Depends(get_db)):
    sub = db.query(Subcategory).filter(Subcategory.id == subcategory_id).first()
    if not sub:
        raise HTTPException(status_code=404, detail="Subcategory not found")
    db.delete(sub)
    db.commit()

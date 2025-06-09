# heymachi_backend/routers/subcategory.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.subcategory import Subcategory
from schemas.subcategory import SubcategoryCreate, SubcategoryOut

router = APIRouter(prefix="/subcategories", tags=["subcategories"])

@router.get("/", response_model=List[SubcategoryOut])
def read_subcategories(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    subcategories = db.query(Subcategory).offset(skip).limit(limit).all()
    return subcategories

@router.post("/", response_model=SubcategoryOut)
def create_subcategory(subcategory: SubcategoryCreate, db: Session = Depends(get_db)):
    db_subcategory = Subcategory(
        name=subcategory.name,
        category_id=subcategory.category_id,
        gst_id=subcategory.gst_id,
    )
    db.add(db_subcategory)
    db.commit()
    db.refresh(db_subcategory)
    return db_subcategory

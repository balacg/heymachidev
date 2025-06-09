# heymachi_backend/routers/tax.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.tax import Tax
from schemas.tax import TaxCreate, TaxOut

router = APIRouter(prefix="/taxes", tags=["taxes"])

@router.get("/", response_model=List[TaxOut])
def read_taxes(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    taxes = db.query(Tax).offset(skip).limit(limit).all()
    return taxes

@router.post("/", response_model=TaxOut)
def create_tax(tax: TaxCreate, db: Session = Depends(get_db)):
    db_tax = Tax(name=tax.name, rate=tax.rate)
    db.add(db_tax)
    db.commit()
    db.refresh(db_tax)
    return db_tax

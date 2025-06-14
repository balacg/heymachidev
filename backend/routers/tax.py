from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.tax import Tax
from schemas.tax import TaxCreate, TaxUpdate, TaxOut

router = APIRouter(prefix="/taxes", tags=["taxes"])

@router.get("/", response_model=List[TaxOut])
def read_taxes(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    taxes = db.query(Tax).offset(skip).limit(limit).all()
    return taxes

@router.post("/", response_model=TaxOut)
def create_tax(tax: TaxCreate, db: Session = Depends(get_db)):
    # Apply default values if missing
    name = tax.name if tax.name else "GST"
    tax_type = tax.type if tax.type else "CGST/SGST"

    db_tax = Tax(name=name, rate=tax.rate, type=tax_type)
    db.add(db_tax)
    db.commit()
    db.refresh(db_tax)
    return db_tax

@router.put("/{tax_id}/", response_model=TaxOut)
def update_tax(
    tax_id: int,
    tax_in: TaxUpdate,
    db: Session = Depends(get_db),
):
    db_tax = db.query(Tax).filter(Tax.id == tax_id).first()
    if not db_tax:
        raise HTTPException(status_code=404, detail="Tax not found")

    db_tax.name = tax_in.name if tax_in.name else "GST"
    db_tax.rate = tax_in.rate
    db_tax.type = tax_in.type if tax_in.type else "CGST/SGST"

    db.commit()
    db.refresh(db_tax)
    return db_tax

@router.delete("/{tax_id}/", status_code=204)
def delete_tax(
    tax_id: int,
    db: Session = Depends(get_db),
):
    db_tax = db.query(Tax).filter(Tax.id == tax_id).first()
    if not db_tax:
        raise HTTPException(status_code=404, detail="Tax not found")
    db.delete(db_tax)
    db.commit()
    return

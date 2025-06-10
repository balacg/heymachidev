#heymachi_backend/routers/payment_type.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.payment_type import PaymentType as PaymentTypeModel
from schemas.payment_type import PaymentTypeCreate, PaymentTypeOut

router = APIRouter(prefix="/payment_types", tags=["payment_types"])

@router.get("/", response_model=List[PaymentTypeOut])
def read_payment_types(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    return db.query(PaymentTypeModel).offset(skip).limit(limit).all()

@router.post("/", response_model=PaymentTypeOut)
def create_payment_type(pt: PaymentTypeCreate, db: Session = Depends(get_db)):
    db_pt = PaymentTypeModel(name=pt.name)
    db.add(db_pt)
    db.commit()
    db.refresh(db_pt)
    return db_pt

@router.put("/{pt_id}/", response_model=PaymentTypeOut)
def update_payment_type(pt_id: int, pt: PaymentTypeCreate, db: Session = Depends(get_db)):
    db_pt = db.query(PaymentTypeModel).filter(PaymentTypeModel.id == pt_id).first()
    if not db_pt:
        raise HTTPException(status_code=404, detail="PaymentType not found")
    db_pt.name = pt.name
    db.commit()
    db.refresh(db_pt)
    return db_pt

@router.delete("/{pt_id}/", status_code=204)
def delete_payment_type(pt_id: int, db: Session = Depends(get_db)):
    db_pt = db.query(PaymentTypeModel).filter(PaymentTypeModel.id == pt_id).first()
    if not db_pt:
        raise HTTPException(status_code=404, detail="PaymentType not found")
    db.delete(db_pt)
    db.commit()
    return

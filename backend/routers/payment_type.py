# heymachi_backend/routers/payment_type.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.payment_type import PaymentType
from schemas.payment_type import PaymentTypeCreate, PaymentTypeOut
from routers.auth import get_current_user
from models.user import User

router = APIRouter(
    prefix="/payment_types",
    tags=["payment_types"],
)

@router.get("/", response_model=List[PaymentTypeOut])
def get_payment_types(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(PaymentType).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=PaymentTypeOut)
def create_payment_type(pt: PaymentTypeCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    new_pt = PaymentType(name=pt.name, business_id=current_user.business_id)
    db.add(new_pt)
    db.commit()
    db.refresh(new_pt)
    return new_pt

@router.put("/{pt_id}", response_model=PaymentTypeOut)
def update_payment_type(pt_id: int, pt: PaymentTypeCreate, db: Session = Depends(get_db)):
    payment_type = db.query(PaymentType).filter_by(id=pt_id).first()
    if not payment_type:
        raise HTTPException(status_code=404, detail="Payment Type not found")
    payment_type.name = pt.name
    db.commit()
    db.refresh(payment_type)
    return payment_type

@router.delete("/{pt_id}", status_code=204)
def delete_payment_type(pt_id: int, db: Session = Depends(get_db)):
    payment_type = db.query(PaymentType).filter_by(id=pt_id).first()
    if not payment_type:
        raise HTTPException(status_code=404, detail="Payment Type not found")
    db.delete(payment_type)
    db.commit()

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.tax import Tax
from schemas.tax import TaxCreate, TaxUpdate, TaxOut
from routers.auth import get_current_user
from models.user import User

router = APIRouter(prefix="/taxes", tags=["taxes"])

@router.get("/", response_model=List[TaxOut])
def get_taxes(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(Tax).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=TaxOut)
def create_tax(
    payload: TaxCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    new_tax = Tax(**payload.dict())
    new_tax.business_id = current_user.business_id
    db.add(new_tax)
    db.commit()
    db.refresh(new_tax)
    return new_tax

@router.put("/{tax_id}/", response_model=TaxOut)
def update_tax(
    tax_id: int,
    tax_in: TaxUpdate,
    db: Session = Depends(get_db),
):
    db_tax = db.query(Tax).filter(Tax.id == tax_id).first()
    if not db_tax:
        raise HTTPException(status_code=404, detail="Tax not found")

    for field, value in tax_in.dict(exclude_unset=True).items():
        setattr(db_tax, field, value)

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

# backend/routers/business_account.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.business_account import BusinessAccount
from schemas.business_account import BusinessAccountCreate, BusinessAccountUpdate, BusinessAccountOut

router = APIRouter()

@router.get("/business-accounts", response_model=List[BusinessAccountOut])
def get_business_accounts(db: Session = Depends(get_db)):
    return db.query(BusinessAccount).all()

@router.post("/business-accounts", response_model=BusinessAccountOut)
def create_business_account(account: BusinessAccountCreate, db: Session = Depends(get_db)):
    new_account = BusinessAccount(**account.dict())
    db.add(new_account)
    db.commit()
    db.refresh(new_account)
    return new_account

@router.put("/business-accounts/{account_id}", response_model=BusinessAccountOut)
def update_business_account(account_id: str, updated: BusinessAccountUpdate, db: Session = Depends(get_db)):
    account = db.query(BusinessAccount).filter(BusinessAccount.id == account_id).first()
    if not account:
        raise HTTPException(status_code=404, detail="Business Account not found")
    for key, value in updated.dict(exclude_unset=True).items():
        setattr(account, key, value)
    db.commit()
    db.refresh(account)
    return account

@router.delete("/business-accounts/{account_id}")
def delete_business_account(account_id: str, db: Session = Depends(get_db)):
    account = db.query(BusinessAccount).filter(BusinessAccount.id == account_id).first()
    if not account:
        raise HTTPException(status_code=404, detail="Business Account not found")
    db.delete(account)
    db.commit()
    return {"message": "Business Account deleted successfully"}

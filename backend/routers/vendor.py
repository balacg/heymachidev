# heymachi_backend/routers/vendor.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.vendor import Vendor
from schemas.vendor import VendorCreate, VendorOut, VendorUpdate
from routers.auth import get_current_user
from models.user import User

router = APIRouter(
    prefix="/vendors",
    tags=["vendors"],
)

@router.get("/", response_model=List[VendorOut])
def get_vendors(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Vendor).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=VendorOut)
def create_vendor(payload: VendorCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    new_vendor = Vendor(**payload.dict())
    new_vendor.business_id = current_user.business_id
    db.add(new_vendor)
    db.commit()
    db.refresh(new_vendor)
    return new_vendor

@router.put("/{vendor_id}", response_model=VendorOut)
def update_vendor(vendor_id: int, vendor_in: VendorUpdate, db: Session = Depends(get_db)):
    vendor = db.query(Vendor).filter(Vendor.id == vendor_id).first()
    if not vendor:
        raise HTTPException(status_code=404, detail="Vendor not found")
    for field, value in vendor_in.dict(exclude_unset=True).items():
        setattr(vendor, field, value)
    db.commit()
    db.refresh(vendor)
    return vendor

@router.delete("/{vendor_id}", status_code=204)
def delete_vendor(vendor_id: int, db: Session = Depends(get_db)):
    vendor = db.query(Vendor).filter(Vendor.id == vendor_id).first()
    if not vendor:
        raise HTTPException(status_code=404, detail="Vendor not found")
    db.delete(vendor)
    db.commit()

# heymachi_backend/routers/vendor.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.vendor import Vendor
from schemas.vendor import VendorCreate, VendorOut, VendorUpdate

router = APIRouter(
    prefix="/vendors",
    tags=["vendors"],
)

@router.get("/", response_model=List[VendorOut])
def list_vendors(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    vendors = db.query(Vendor).offset(skip).limit(limit).all()
    return vendors

@router.post("/", response_model=VendorOut)
def create_vendor(vendor_in: VendorCreate, db: Session = Depends(get_db)):
    db_vendor = db.query(Vendor).filter(Vendor.phone == vendor_in.phone).first()
    if db_vendor:
        raise HTTPException(status_code=400, detail="Vendor with this phone number already exists")
    new_vendor = Vendor(**vendor_in.dict())
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

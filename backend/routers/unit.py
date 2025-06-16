# heymachi_backend/routers/unit.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.unit import Unit
from models.user import User
from routers.auth import get_current_user
from schemas.unit import UnitCreate, UnitUpdate, UnitOut

router = APIRouter(
    prefix="/units",
    tags=["units"],
)

@router.get("/", response_model=List[UnitOut])
def get_units(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(Unit).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=UnitOut)
def create_unit(
    payload: UnitCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    unit = Unit(**payload.dict())
    unit.business_id = current_user.business_id
    db.add(unit)
    db.commit()
    db.refresh(unit)
    return unit

@router.put("/{unit_id}", response_model=UnitOut)
def update_unit(
    unit_id: int,
    unit_in: UnitUpdate,
    db: Session = Depends(get_db),
):
    unit = db.query(Unit).filter(Unit.id == unit_id).first()
    if not unit:
        raise HTTPException(status_code=404, detail="Unit not found")
    for field, value in unit_in.dict(exclude_unset=True).items():
        setattr(unit, field, value)
    db.commit()
    db.refresh(unit)
    return unit

@router.delete("/{unit_id}", status_code=204)
def delete_unit(
    unit_id: int,
    db: Session = Depends(get_db),
):
    unit = db.query(Unit).filter(Unit.id == unit_id).first()
    if not unit:
        raise HTTPException(status_code=404, detail="Unit not found")
    db.delete(unit)
    db.commit()

# heymachi_backend/routers/unit.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.unit import Unit
from schemas.unit import UnitCreate, UnitOut

router = APIRouter(prefix="/units", tags=["units"])

@router.get("/", response_model=List[UnitOut])
def read_units(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    units = db.query(Unit).offset(skip).limit(limit).all()
    return units

@router.post("/", response_model=UnitOut)
def create_unit(unit: UnitCreate, db: Session = Depends(get_db)):
    db_unit = Unit(name=unit.name, abbreviation=unit.abbreviation)
    db.add(db_unit)
    db.commit()
    db.refresh(db_unit)
    return db_unit

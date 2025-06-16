# backend/routers/industry.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models.industry import Industry

router = APIRouter()

@router.get("/industries")
def list_industries(db: Session = Depends(get_db)):
    return db.query(Industry).all()

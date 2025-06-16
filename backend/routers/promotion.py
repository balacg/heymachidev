# backend/routers/promotion.py

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from models.promotion import Promotion
from schemas.promotion import PromotionCreate, PromotionUpdate, PromotionOut
from models.user import User
from core.security import get_current_user
from utils.id_generator import generate_custom_id

router = APIRouter(prefix="/promotions", tags=["promotions"])

@router.get("/", response_model=List[PromotionOut])
def get_promotions(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Promotion).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=PromotionOut, status_code=status.HTTP_201_CREATED)
def create_promotion(payload: PromotionCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    new_promo = Promotion(
        id=generate_custom_id("PRM", db, Promotion),
        title=payload.title,
        description=payload.description,
        discount_percentage=payload.discount_percentage,
        start_date=payload.start_date,
        end_date=payload.end_date,
        business_id=current_user.business_id
    )
    db.add(new_promo)
    db.commit()
    db.refresh(new_promo)
    return new_promo

@router.put("/{promotion_id}", response_model=PromotionOut)
def update_promotion(promotion_id: str, payload: PromotionUpdate, db: Session = Depends(get_db)):
    promo = db.query(Promotion).filter(Promotion.id == promotion_id).first()
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion not found")

    for field, value in payload.dict(exclude_unset=True).items():
        setattr(promo, field, value)

    db.commit()
    db.refresh(promo)
    return promo

@router.delete("/{promotion_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_promotion(promotion_id: str, db: Session = Depends(get_db)):
    promo = db.query(Promotion).filter(Promotion.id == promotion_id).first()
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion not found")
    db.delete(promo)
    db.commit()

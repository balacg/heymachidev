# backend/routers/promotion.py

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.promotion import Promotion as PromotionModel
from schemas.promotion import PromotionCreate, PromotionUpdate, PromotionOut

router = APIRouter()

@router.get("/promotions", response_model=List[PromotionOut])
def get_promotions(db: Session = Depends(get_db)):
    return db.query(PromotionModel).all()

@router.post("/promotions", response_model=PromotionOut)
def create_promotion(promotion: PromotionCreate, db: Session = Depends(get_db)):
    db_promo = PromotionModel(**promotion.dict())
    db.add(db_promo)
    db.commit()
    db.refresh(db_promo)
    return db_promo

@router.put("/promotions/{promotion_id}", response_model=PromotionOut)
def update_promotion(promotion_id: str, updated: PromotionUpdate, db: Session = Depends(get_db)):
    promo = db.query(PromotionModel).filter(PromotionModel.id == promotion_id).first()
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion not found")
    for field, value in updated.dict(exclude_unset=True).items():
        setattr(promo, field, value)
    db.commit()
    db.refresh(promo)
    return promo

@router.delete("/promotions/{promotion_id}")
def delete_promotion(promotion_id: str, db: Session = Depends(get_db)):
    promo = db.query(PromotionModel).filter(PromotionModel.id == promotion_id).first()
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion not found")
    db.delete(promo)
    db.commit()
    return {"message": "Deleted successfully"}

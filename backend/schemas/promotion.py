# backend/schemas/promotion.py

from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class PromotionBase(BaseModel):
    title: str
    description: str
    discountPercentage: float
    startDate: datetime
    endDate: datetime

class PromotionCreate(PromotionBase):
    pass

class PromotionUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    discountPercentage: Optional[float] = None
    startDate: Optional[datetime] = None
    endDate: Optional[datetime] = None

class PromotionOut(PromotionBase):
    id: str

    class Config:
        orm_mode = True

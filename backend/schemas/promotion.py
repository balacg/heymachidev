# backend/schemas/promotion.py

from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional

class PromotionBase(BaseModel):
    title: str
    description: str
    discount_percentage: float
    start_date: datetime
    end_date: datetime

class PromotionCreate(PromotionBase):
    pass

class PromotionUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    discount_percentage: Optional[float] = None
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None

class PromotionOut(BaseModel):
    id: str
    title: str
    description: str
    discount_percentage: float = Field(..., alias="discount_percentage")
    start_date: datetime = Field(..., alias="start_date")
    end_date: datetime = Field(..., alias="end_date")

    class Config:
        orm_mode = True
        allow_population_by_field_name = True

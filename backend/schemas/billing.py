# heymachi_backend/schemas/billing.py

from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class BillItemCreate(BaseModel):
    product_id: int
    quantity: int

class BillItemOut(BaseModel):
    id: int
    product_id: int
    quantity: int
    price: float
    gst_amount: float

    class Config:
        orm_mode = True

class BillCreate(BaseModel):
    customer_id: Optional[int]
    customer_name: Optional[str]
    customer_phone: Optional[str]
    payment_mode: str
    items: List[BillItemCreate]
    promo_title: Optional[str] = None
    promo_discount_percentage: Optional[float] = None
    promo_discount_value: Optional[float] = None

class BillOut(BaseModel):
    id: int
    customer_id: Optional[int]
    customer_name: Optional[str]
    customer_phone: Optional[str]
    bill_date: datetime
    payment_mode: str
    total_amount: float
    total_gst: float
    subtotal: float
    items: List[BillItemOut]

    class Config:
        orm_mode = True

# app/schemas/transaction.py

from pydantic import BaseModel
from datetime import datetime
from typing import List
from typing import Optional

class TransactionRecord(BaseModel):
    bill_id:         str
    line_id:         str
    date:            datetime
    customer_name:   str
    customer_phone:  str
    customer_gst:    str
    address:         str
    product_name:    str
    category:        str
    quantity:        int
    unit_price:      float
    gst_slab:        str
    gst_rate:        float
    tax_amount:      float
    total_amount:    float
    payment_mode:    str
    branch:          str
    promo_title: Optional[str] = None
    promo_discount_percentage: Optional[float] = None
    promo_discount_value: Optional[float] = None
    class Config:
        orm_mode = True

class BillSchema(BaseModel):
    id:              str
    date:            datetime
    customer_name:   str
    customer_phone:  str
    customer_gst:    str
    address:         str
    payment_mode:    str
    total_amount:    float
    branch:          str
    promo_title: Optional[str] = None
    promo_discount_percentage: Optional[float] = None
    promo_discount_value: Optional[float] = None

    class Config:
        orm_mode = True

class TransactionPayload(BaseModel):
    bill: BillSchema
    bill_items: List[TransactionRecord]

# hm_industries/restaurant/backend/models/open_order_model.py

from ..bootstrap import *

from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

class OpenOrderLineItemModel(BaseModel):
    productName: str
    quantity: int
    unitPrice: float
    addedAt: datetime = Field(default_factory=datetime.utcnow)
    cancelled: bool = False
    

class OpenOrderModel(BaseModel):
    orderId: str  # UUID or generated token
    orderType: str  # 'DINE_IN' | 'TAKEAWAY' | 'DELIVERY'
    tableNo: Optional[str] = None  # For DINE_IN only
    pax: Optional[int] = None      # For DINE_IN only
    tokenNo: Optional[int] = None  # For TAKEAWAY/DELIVERY tracking
    status: str = 'OPEN'  # OPEN | CLOSED | CANCELLED
    createdAt: datetime = Field(default_factory=datetime.utcnow)
    updatedAt: datetime = Field(default_factory=datetime.utcnow)
    items: List[OpenOrderLineItemModel] = []
    customerName: Optional[str] = None
    customerPhone: Optional[str] = None
    notes: Optional[str] = None


# hm_industries/restaurant/backend/schemas/open_order_schema.py

from ..bootstrap import *

from typing import Optional, List, Dict
from pydantic import BaseModel, Field
from datetime import datetime

class OpenOrderBase(BaseModel):
    dining_type: str
    table_no: Optional[str] = None
    pax: Optional[int] = None
    token: Optional[str] = Field(None, alias="token_number")  # Aligns with DB model field
    cart_data: Dict  # This will hold the items in the cart

class OpenOrderCreate(OpenOrderBase):
    pass

class OpenOrderUpdate(OpenOrderBase):
    pass

class OpenOrderOut(OpenOrderBase):
    id: int
    updated_at: datetime

    class Config:
        orm_mode = True
        allow_population_by_field_name = True  # Ensures aliasing works both ways

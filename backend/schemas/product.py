# heymachi_backend/schemas/product.py

from typing import Optional
from pydantic import BaseModel

class ProductBase(BaseModel):
    name: str
    price: float
    category_id: int
    subcategory_id: Optional[int] = None
    gst_id: int

class ProductCreate(ProductBase):
    pass

class ProductOut(BaseModel):
    id: int
    name: str
    price: float
    category_id: int
    subcategory_id: Optional[int] = None
    gst_id: int
    category_name: str  # 👈 Add this for UI

    class Config:
        orm_mode = True

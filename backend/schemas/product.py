# backend/schemas/product.py

from pydantic import BaseModel
from typing import Optional


class ProductBase(BaseModel):
    name: str
    price: float
    category_id: Optional[str]
    subcategory_id: Optional[str]
    gst_id: Optional[int]
    unit_id: Optional[int]
    is_active: Optional[bool] = True


class ProductCreate(ProductBase):
    pass


class ProductUpdate(BaseModel):
    name: Optional[str]
    price: Optional[float]
    category_id: Optional[str]
    subcategory_id: Optional[str]
    gst_id: Optional[int]
    unit_id: Optional[int]
    is_active: Optional[bool]


class ProductOut(BaseModel):
    id: str
    name: str
    price: float
    category_id: Optional[str]
    subcategory_id: Optional[str]
    gst_id: Optional[int]
    unit_id: Optional[int]
    is_active: Optional[bool]
    business_id: str

    category_name: Optional[str]
    subcategory_name: Optional[str]
    gst_rate: Optional[float]

    class Config:
        orm_mode = True

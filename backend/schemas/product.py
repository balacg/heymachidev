from typing import Optional
from pydantic import BaseModel

class ProductBase(BaseModel):
    name: str
    price: float
    category_id: int
    subcategory_id: Optional[int] = None
    gst_id: Optional[int] = None

class ProductCreate(ProductBase):
    pass

class ProductUpdate(ProductBase):
    pass

class ProductOut(ProductBase):
    id: int
    category_name: str

    class Config:
        orm_mode = True
        from_attributes = True 

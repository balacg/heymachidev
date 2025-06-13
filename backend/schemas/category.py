# heymachi_backend/schemas/category.py

from pydantic import BaseModel
from typing import Optional

class CategoryBase(BaseModel):
    name: str
    gst_id: Optional[int]

class CategoryCreate(CategoryBase):
    pass

class CategoryUpdate(CategoryBase):
    pass

class CategoryOut(CategoryBase):
    id: int

    class Config:
        orm_mode = True

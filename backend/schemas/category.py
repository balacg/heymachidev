# heymachi_backend/schemas/category.py

from pydantic import BaseModel

class CategoryBase(BaseModel):
    name: str
    gst_id: int

class CategoryCreate(CategoryBase):
    pass

class CategoryOut(CategoryBase):
    id: int

    class Config:
        orm_mode = True

# heymachi_backend/schemas/subcategory.py

from pydantic import BaseModel

class SubcategoryBase(BaseModel):
    name: str
    category_id: int
    gst_id: int

class SubcategoryCreate(SubcategoryBase):
    pass

class SubcategoryOut(SubcategoryBase):
    id: int

    class Config:
        orm_mode = True

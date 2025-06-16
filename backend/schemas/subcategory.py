# heymachi_backend/schemas/subcategory.py

from pydantic import BaseModel
from typing import Optional

class SubcategoryBase(BaseModel):
    name: str
    category_id: str
    gst_id: Optional[int]

class SubcategoryCreate(SubcategoryBase):
    pass

class SubcategoryUpdate(SubcategoryBase):
    pass

class SubcategoryOut(SubcategoryBase):
    id: str

    class Config:
        orm_mode = True

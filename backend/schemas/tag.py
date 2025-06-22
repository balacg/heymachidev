#heymachi_backend/schemas/tag.py

from typing import Optional
from pydantic import BaseModel

class TagBase(BaseModel):
    tag_type: str
    tag_value: str
    business_id: str
    is_active: bool = True

class TagCreate(TagBase):
    pass

class TagOut(TagBase):
    id: int

    class Config:
        orm_mode = True

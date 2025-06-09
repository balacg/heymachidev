# heymachi_backend/schemas/unit.py

from pydantic import BaseModel
from typing import Optional

class UnitBase(BaseModel):
    name: str
    abbreviation: Optional[str] = None

class UnitCreate(UnitBase):
    pass

class UnitOut(UnitBase):
    id: int

    class Config:
        orm_mode = True

from pydantic import BaseModel
from typing import Optional

class UnitCreate(BaseModel):
    name: str
    description: Optional[str] = None

class UnitUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None

class UnitOut(BaseModel):
    id: int
    name: str
    description: Optional[str]

    class Config:
        orm_mode = True


# backend/schemas/restaurant/table.py

from pydantic import BaseModel
from typing import Optional

class TableBase(BaseModel):
    name: str
    capacity: int

class TableCreate(TableBase):
    pass

class TableUpdate(TableBase):
    pass

class TableOut(TableBase):
    id: str

    class Config:
        orm_mode = True

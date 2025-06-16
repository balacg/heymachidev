# backend/schemas/industry.py

from pydantic import BaseModel

class IndustryBase(BaseModel):
    name: str

class IndustryOut(IndustryBase):
    id: str

    class Config:
        orm_mode = True

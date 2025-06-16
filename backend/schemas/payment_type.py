from pydantic import BaseModel
from typing import Optional

class PaymentTypeCreate(BaseModel):
    name: str
    description: Optional[str] = None

class PaymentTypeUpdate(BaseModel):
    name: Optional[str] = None
    description: Optional[str] = None

class PaymentTypeOut(BaseModel):
    id: int
    name: str
    description: Optional[str] = None

    class Config:
        orm_mode = True

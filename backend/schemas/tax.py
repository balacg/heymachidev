# heymachi_backend/schemas/tax.py

from pydantic import BaseModel

class TaxBase(BaseModel):
    name: str
    rate: float

class TaxCreate(TaxBase):
    pass

class TaxOut(TaxBase):
    id: int

    class Config:
        orm_mode = True

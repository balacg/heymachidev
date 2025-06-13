# heymachi_backend/schemas/tax.py

from pydantic import BaseModel
from typing import Optional

class TaxBase(BaseModel):
    name: Optional[str] = "GST"
    rate: float
    type: Optional[str] = "CGST/SGST"

class TaxCreate(TaxBase):
    pass

class TaxUpdate(TaxBase):
    pass

class TaxOut(TaxBase):
    id: int

    class Config:
        orm_mode = True

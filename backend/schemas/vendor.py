# heymachi_backend/schemas/vendor.py

from pydantic import BaseModel, EmailStr
from typing import Optional

class VendorBase(BaseModel):
    name: str
    phone: str
    email: Optional[EmailStr] = None
    gst_number: Optional[str] = None
    address: Optional[str] = None

class VendorCreate(VendorBase):
    pass

class VendorUpdate(VendorBase):
    pass

class VendorOut(VendorBase):
    id: int

    class Config:
        orm_mode = True

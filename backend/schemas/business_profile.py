# backend/schemas/business_profile.py

from pydantic import BaseModel
from typing import Optional

class BusinessProfileBase(BaseModel):
    name: str
    gst_number: Optional[str] = None
    footer_note: Optional[str] = None

class BusinessProfileOut(BusinessProfileBase):
    pass

class BusinessProfileUpdate(BusinessProfileBase):
    pass
    
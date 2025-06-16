# backend/schemas/business_account.py

from pydantic import BaseModel
from typing import Optional, Dict

class BusinessAccountBase(BaseModel):
    name: str
    industry_id: str
    owner_id: Optional[str] = None
    features_enabled: Optional[Dict[str, bool]] = {}

class BusinessAccountCreate(BusinessAccountBase):
    id: str  # You can auto-generate BIZ-000X from backend too, if needed

class BusinessAccountUpdate(BaseModel):
    name: Optional[str] = None
    industry_id: Optional[str] = None
    owner_id: Optional[str] = None
    features_enabled: Optional[Dict[str, bool]] = None

class BusinessAccountOut(BusinessAccountBase):
    id: str

    class Config:
        orm_mode = True

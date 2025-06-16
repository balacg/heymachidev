# backend/schemas/branch.py

from pydantic import BaseModel
from typing import Optional

class BranchBase(BaseModel):
    name: str
    address: Optional[str]
    state: str
    phone: Optional[str]
    email: Optional[str]
    gst_number: Optional[str]

class BranchCreate(BranchBase):
    pass

class BranchOut(BranchBase):
    id: str
    business_id: str

    class Config:
        orm_mode = True

class BranchUpdate(BaseModel):
    name: Optional[str]
    address: Optional[str]
    state: Optional[str]
    phone: Optional[str]
    email: Optional[str]
    gst_number: Optional[str]
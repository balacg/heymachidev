# backend/models/branch.py

from sqlalchemy import Column, String, Text, ForeignKey
from .base import Base

class Branch(Base):
    __tablename__ = "branches"

    id = Column(String, primary_key=True)
    business_id = Column(String, ForeignKey("business_accounts.id"), nullable=False)
    name = Column(String, nullable=False)
    address = Column(Text)
    state = Column(String, nullable=False)
    phone = Column(String)
    email = Column(String)
    gst_number = Column(String)

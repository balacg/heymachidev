# backend/models/business_account.py

from sqlalchemy import Column, String, ForeignKey, JSON
from sqlalchemy.orm import relationship
from .base import Base

class BusinessAccount(Base):
    __tablename__ = "business_accounts"

    id = Column(String, primary_key=True, index=True)  # e.g., BIZ-0001
    name = Column(String, unique=True, index=True)
    industry_id = Column(String, ForeignKey("industries.id"))
    owner_id = Column(String, index=True)  # Optional: Can link to user table later
    features_enabled = Column(JSON, nullable=True)  # e.g., { "loyalty": true, "billing": true }

    industry = relationship("Industry", backref="business_accounts")

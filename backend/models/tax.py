# backend/models/tax.py

from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Tax(Base):
    __tablename__ = "taxes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    rate = Column(Float)
    type = Column(String)
    business_id = Column(String, ForeignKey("business_accounts.id"))

    business = relationship("BusinessAccount", backref="taxes")

    # ✅ Fix this line
    products = relationship("Product", back_populates="gst")

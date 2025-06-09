# heymachi_backend/models/tax.py

from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.orm import relationship
from .base import Base

class Tax(Base):
    __tablename__ = "taxes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    rate = Column(Float, nullable=False)

    categories = relationship("Category", back_populates="gst")
    subcategories = relationship("Subcategory", back_populates="gst")
    products = relationship("Product", back_populates="gst")

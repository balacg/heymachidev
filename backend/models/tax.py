from sqlalchemy import Column, Integer, String, Float
from sqlalchemy.orm import relationship
from .base import Base

class Tax(Base):
    __tablename__ = "taxes"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    rate = Column(Float)
    type = Column(String)

    products = relationship("Product", back_populates="tax", foreign_keys="Product.gst_id")  # ✅ Fixed

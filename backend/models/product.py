# heymachi_backend/models/product.py

from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    price = Column(Float, nullable=False)
    category_id = Column(Integer, ForeignKey("categories.id"), nullable=False)
    subcategory_id = Column(Integer, ForeignKey("subcategories.id"), nullable=True)
    gst_id = Column(Integer, ForeignKey("taxes.id"), nullable=False)

    category = relationship("Category")
    subcategory = relationship("Subcategory")
    gst = relationship("Tax")

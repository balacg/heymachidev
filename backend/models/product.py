from sqlalchemy import Column, Integer, String, Float, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Product(Base):
    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    price = Column(Float)
    category_id = Column(Integer, ForeignKey("categories.id"))
    subcategory_id = Column(Integer, ForeignKey("subcategories.id"))
    gst_id = Column(Integer, ForeignKey("taxes.id"), nullable=True)  # ✅ Added FK

    category = relationship("Category")
    subcategory = relationship("Subcategory", back_populates="products")
    tax = relationship("Tax", back_populates="products")  # ✅ Added

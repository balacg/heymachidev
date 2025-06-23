# backend/models/product.py

from sqlalchemy import Column, String, Float, Boolean, ForeignKey, Integer
from sqlalchemy.orm import relationship
from .base import Base
from utils.id_generator import generate_custom_id 
from .tag import Tag

class Product(Base):
    __tablename__ = "products"

    id = Column(String, primary_key=True)
    name = Column(String, index=True)
    price = Column(Float)

    category_id = Column(String, ForeignKey("categories.id"))
    subcategory_id = Column(String, ForeignKey("subcategories.id"), nullable=True)
    gst_id = Column(Integer, ForeignKey("taxes.id"), nullable=True)
    unit_id = Column(Integer, ForeignKey("units.id"), nullable=True)

    is_active = Column(Boolean, default=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))

    business = relationship("BusinessAccount", backref="products")
    subcategory = relationship("Subcategory", back_populates="products")
    gst = relationship("Tax", foreign_keys=[gst_id], back_populates="products") 
    tags = relationship("Tag", secondary="product_tags", backref="products")
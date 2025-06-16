# heymachi_backend/models/category.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base
from utils.id_generator import generate_custom_id  # make sure this is present
class Category(Base):
    __tablename__ = "categories"

    id = Column(String, primary_key=True)
    name = Column(String, unique=True, index=True)
    gst_id = Column(Integer, nullable=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))

    
    subcategories = relationship("Subcategory", back_populates="category")
    business = relationship("BusinessAccount", backref="categories")
# heymachi_backend/models/category.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Category(Base):
    __tablename__ = "categories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)
    gst_id = Column(Integer, nullable=True)

    # ✅ Add this:
    subcategories = relationship("Subcategory", back_populates="category")

# heymachi_backend/models/subcategory.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Subcategory(Base):
    __tablename__ = "subcategories"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    category_id = Column(Integer, ForeignKey("categories.id"))
    gst_id = Column(Integer, nullable=True)

    # ✅ This line caused the error before — now fixed by defining the other side in Category
    category = relationship("Category", back_populates="subcategories")
    products = relationship("Product", back_populates="subcategory")

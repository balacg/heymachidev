# heymachi_backend/models/subcategory.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base
from utils.id_generator import generate_custom_id 

class Subcategory(Base):
    __tablename__ = "subcategories"

    id = Column(String, primary_key=True, index=True)
    name = Column(String, index=True)
    category_id = Column(String, ForeignKey("categories.id"))
    gst_id = Column(Integer, nullable=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))

    # ✅ This line caused the error before — now fixed by defining the other side in Category
    category = relationship("Category", back_populates="subcategories")
    products = relationship("Product", back_populates="subcategory")
    business = relationship("BusinessAccount", backref="subcategories")
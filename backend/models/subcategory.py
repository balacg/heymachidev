# heymachi_backend/models/subcategory.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Subcategory(Base):
    __tablename__ = "subcategories"
    __table_args__ = {'extend_existing': True}

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    category_id = Column(Integer, ForeignKey("categories.id"), nullable=False)
    gst_id = Column(Integer, ForeignKey("taxes.id"), nullable=False)

    category = relationship("Category")
    gst = relationship("Tax")

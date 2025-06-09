# heymachi_backend/models/category.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Category(Base):
    __tablename__ = "categories"  # Correct table name

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    gst_id = Column(Integer, ForeignKey("taxes.id"), nullable=False)  # No category_id here for Category

    gst = relationship("Tax")

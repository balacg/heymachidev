from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Tag(Base):
    __tablename__ = "tags_master"

    id = Column(Integer, primary_key=True, index=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))
    tag_type = Column(String)
    tag_value = Column(String)
    is_active = Column(Integer)

   # products = relationship("Product", secondary="product_tags", back_populates="tags")

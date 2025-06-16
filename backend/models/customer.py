# heymachi_backend/models/customer.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class Customer(Base):
    __tablename__ = "customers"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    phone = Column(String, nullable=False, unique=True)
    email = Column(String, nullable=True)
    gst = Column(String, nullable=True)
    address = Column(String, nullable=True)
    state = Column(String, nullable=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))
    
    business = relationship("BusinessAccount", backref="customers")
    bills = relationship("Bill", back_populates="customer")

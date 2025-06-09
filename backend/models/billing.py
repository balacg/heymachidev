# heymachi_backend/models/billing.py

from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, Float
from sqlalchemy.orm import relationship
from .base import Base
from datetime import datetime

class Bill(Base):
    __tablename__ = "bills"

    id = Column(Integer, primary_key=True, index=True)
    customer_id = Column(Integer, ForeignKey("customers.id"), nullable=True)
    customer_name = Column(String, nullable=True)  # For guest customers
    customer_phone = Column(String, nullable=True)
    bill_date = Column(DateTime, default=datetime.utcnow)
    payment_mode = Column(String, nullable=False)
    total_amount = Column(Float, nullable=False)
    total_gst = Column(Float, nullable=False)
    subtotal = Column(Float, nullable=False)

    items = relationship("BillItem", back_populates="bill", cascade="all, delete-orphan")
    customer = relationship("Customer")

class BillItem(Base):
    __tablename__ = "bill_items"

    id = Column(Integer, primary_key=True, index=True)
    bill_id = Column(Integer, ForeignKey("bills.id"), nullable=False)
    product_id = Column(Integer, ForeignKey("products.id"), nullable=False)
    quantity = Column(Integer, nullable=False)
    price = Column(Float, nullable=False)
    gst_amount = Column(Float, nullable=False)

    bill = relationship("Bill", back_populates="items")
    product = relationship("Product")

# heymachi_backend/models/billing.py

from sqlalchemy import Column, String, Float, ForeignKey, Integer, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime
from .base import Base

class Bill(Base):
    __tablename__ = "bills"

    id             = Column(String, primary_key=True, index=True)
    date           = Column(DateTime, default=datetime.utcnow)
    customer_id    = Column(Integer, ForeignKey("customers.id"))  # ✅ Added FK to customers table
    customer_name  = Column(String, nullable=False)
    customer_phone = Column(String, nullable=False)
    customer_gst   = Column(String, nullable=True)
    address        = Column(String, nullable=True)
    payment_mode   = Column(String, nullable=False)
    total_amount   = Column(Float, nullable=False)
    branch         = Column(String, nullable=False)

    items    = relationship("BillItem", back_populates="bill", cascade="all, delete-orphan")
    customer = relationship("Customer", back_populates="bills")  # ✅ Added relationship


class BillItem(Base):
    __tablename__ = "bill_items"

    id             = Column(String, primary_key=True, index=True)
    bill_id        = Column(String, ForeignKey("bills.id"))
    date           = Column(DateTime, default=datetime.utcnow)
    customer_name  = Column(String, nullable=False)
    customer_phone = Column(String, nullable=False)
    customer_gst   = Column(String, nullable=True)
    address        = Column(String, nullable=True)
    product_name   = Column(String, nullable=False)
    category       = Column(String, nullable=True)
    quantity       = Column(Integer, nullable=False)
    unit_price     = Column(Float, nullable=False)
    gst_slab       = Column(String, nullable=False)
    gst_rate       = Column(Float, nullable=False)
    tax_amount     = Column(Float, nullable=False)
    total_amount   = Column(Float, nullable=False)
    payment_mode   = Column(String, nullable=False)
    branch         = Column(String, nullable=False)

    bill = relationship("Bill", back_populates="items")

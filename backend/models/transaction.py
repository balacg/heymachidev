# app/models/transaction.py

from sqlalchemy import Column, String, Integer, Float, DateTime
from .base import Base

class Transaction(Base):
    __tablename__ = "transactions"

    id              = Column(Integer, primary_key=True, index=True)
    bill_id         = Column(String, index=True)
    line_id         = Column(String, unique=True, index=True)
    date            = Column(DateTime)
    customer_name   = Column(String)
    customer_phone  = Column(String)
    customer_gst    = Column(String)
    address         = Column(String)
    product_name    = Column(String)
    category        = Column(String)
    quantity        = Column(Integer)
    unit_price      = Column(Float)
    gst_slab        = Column(String)
    gst_rate        = Column(Float)
    tax_amount      = Column(Float)
    total_amount    = Column(Float)
    payment_mode    = Column(String)
    branch          = Column(String)

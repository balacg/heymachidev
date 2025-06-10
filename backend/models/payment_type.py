#heymachi_backend/models/payment_type.py

from sqlalchemy import Column, Integer, String
from .base import Base

class PaymentType(Base):
    __tablename__ = "payment_types"

    id   = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)


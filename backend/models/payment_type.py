#heymachi_backend/models/payment_type.py

from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base

class PaymentType(Base):
    __tablename__ = "payment_types"

    id   = Column(Integer, primary_key=True, index=True)
    name = Column(String, unique=True, index=True)

    business_id = Column(String, ForeignKey("business_accounts.id"))
    business = relationship("BusinessAccount", backref="payment_types")
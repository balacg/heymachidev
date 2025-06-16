# heymachi_backend/models/promotion.py

from sqlalchemy import Column, String, Float, DateTime, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base
from datetime import datetime

class Promotion(Base):
    __tablename__ = "promotions"

    id = Column(String, primary_key=True, index=True)  # e.g., PRM-0001
    title = Column(String, nullable=False)
    description = Column(String, nullable=True)
    discount_percentage = Column(Float, nullable=False)
    start_date = Column(DateTime, default=datetime.utcnow)
    end_date = Column(DateTime, default=datetime.utcnow)
    is_active = Column(Boolean, default=True)

    business_id = Column(String, ForeignKey("business_accounts.id"))
    business = relationship("BusinessAccount", backref="promotions")

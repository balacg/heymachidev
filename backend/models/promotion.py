# backend/models/promotion.py

from sqlalchemy import Column, String, Float, DateTime
from .base import Base
from datetime import datetime
import uuid

class Promotion(Base):
    __tablename__ = "promotions"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid.uuid4()))
    title = Column(String, nullable=False)
    description = Column(String, nullable=True)
    discountPercentage = Column(Float, nullable=False)
    startDate = Column(DateTime, default=datetime.utcnow)
    endDate = Column(DateTime, default=datetime.utcnow)

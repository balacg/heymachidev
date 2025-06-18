# hm_industries/restaurant/backend/dbmodels/open_order_db.py

from ..bootstrap import *

from sqlalchemy import Column, String, Integer, Float, DateTime, Text
from sqlalchemy.sql import func
import uuid
import json
from heymachi.backend.models.base import Base 

class OpenOrderDB(Base):
    __tablename__ = "open_orders"
    __table_args__ = {'extend_existing': True}

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid.uuid4()))
    dining_mode = Column(String, index=True)         # DINE_IN / TAKEAWAY / DELIVERY
    table_no = Column(String, nullable=True)         # Only for DINE_IN
    pax = Column(Integer, nullable=True)             # Only for DINE_IN
    token_no = Column(String, nullable=True)         # For TAKEAWAY / DELIVERY
    customer_name = Column(String, nullable=True)
    status = Column(String, default="OPEN")          # OPEN / COMPLETED / CANCELLED
    items = Column(Text, nullable=False)             # Store JSON string of items
    total_amount = Column(Float, nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    def to_dict(self):
        return {
            "id": self.id,
            "dining_mode": self.dining_mode,
            "table_no": self.table_no,
            "pax": self.pax,
            "token_no": self.token_no,
            "customer_name": self.customer_name,
            "status": self.status,
            "items": json.loads(self.items),
            "total_amount": self.total_amount,
            "created_at": self.created_at.isoformat() if self.created_at else None,
        }

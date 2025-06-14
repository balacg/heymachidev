
# backend/models/restaurant/table.py

from sqlalchemy import Column, String, Integer
from models.base import Base
import uuid

class RestaurantTable(Base):
    __tablename__ = "restaurant_tables"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid.uuid4()))
    name = Column(String, nullable=False)
    capacity = Column(Integer, nullable=False)

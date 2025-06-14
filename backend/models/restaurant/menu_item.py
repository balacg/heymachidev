# backend/models/restaurant/menu_item.py

from sqlalchemy import Column, String, Float
from models.base import Base
import uuid

class MenuItem(Base):
    __tablename__ = "restaurant_menu_items"

    id = Column(String, primary_key=True, index=True, default=lambda: str(uuid.uuid4()))
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    price = Column(Float, nullable=False)
    category = Column(String, nullable=True)

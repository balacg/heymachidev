# heymachi_backend/models/unit.py

from sqlalchemy import Column, Integer, String
from .base import Base

class Unit(Base):
    __tablename__ = "units"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    abbreviation = Column(String, nullable=True)

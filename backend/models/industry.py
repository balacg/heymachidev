# backend/models/industry.py

from sqlalchemy import Column, String
from sqlalchemy.orm import declarative_base

from .base import Base

class Industry(Base):
    __tablename__ = "industries"

    id = Column(String, primary_key=True, index=True)  # e.g., RES-0001
    name = Column(String, unique=True, index=True)

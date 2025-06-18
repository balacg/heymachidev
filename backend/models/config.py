# heymachi_backend/models/config.py

from sqlalchemy import Column, String
from heymachi.backend.database import Base

class Config(Base):
    __tablename__ = 'configs'

    key = Column(String, primary_key=True, index=True)
    value = Column(String, nullable=False)

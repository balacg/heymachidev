# heymachi/backend/models/token_sequence.py

from sqlalchemy import Column, Integer, String, Date, UniqueConstraint
from .base import Base

class TokenSequence(Base):
    __tablename__ = "token_sequence"
    __table_args__ = (UniqueConstraint('type_code', 'date', name='uq_token_type_date'),)

    id = Column(Integer, primary_key=True, index=True)
    type_code = Column(String, index=True)
    date = Column(Date, index=True)
    sequence = Column(Integer, default=1)

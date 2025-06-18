# heymachi_backend/models/business_profile.py

from sqlalchemy import Column, String, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import relationship
from .base import Base
import uuid

class BusinessProfile(Base):
    __tablename__ = "business_profiles"
    __table_args__ = {'extend_existing': True}

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    business_id = Column(String, ForeignKey("business_accounts.id"), unique=True, nullable=False)

    name = Column(String, nullable=False)
    gst_number = Column(String)
    state = Column(String, nullable=True)
    footer_note = Column(String)

    business = relationship("BusinessAccount", backref="profile")

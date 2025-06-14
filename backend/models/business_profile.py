from sqlalchemy import Column, String
from models.base import Base
import uuid
from sqlalchemy.dialects.postgresql import UUID

class BusinessProfile(Base):
    __tablename__ = "business_profiles"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name = Column(String, nullable=False)
    gst_number = Column(String)
    state = Column(String, nullable=True)
    footer_note = Column(String)

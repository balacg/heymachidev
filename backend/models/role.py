from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship
from .base import Base
from .association_tables import user_roles

class Role(Base):
    __tablename__ = "roles"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(String, nullable=True)
    business_id = Column(String, ForeignKey("business_accounts.id"))

    users = relationship("User", secondary=user_roles, back_populates="roles")
    business = relationship("BusinessAccount", backref="roles")

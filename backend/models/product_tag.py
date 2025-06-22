from sqlalchemy import Column, Integer, ForeignKey, Table
from .base import Base

# This is an association table — don't define it as a class
product_tags = Table(
    "product_tags",
    Base.metadata,
    Column("product_id", ForeignKey("products.id"), primary_key=True),
    Column("tag_id", ForeignKey("tags_master.id"), primary_key=True)
)

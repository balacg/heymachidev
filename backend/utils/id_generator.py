from sqlalchemy.orm import Session
from typing import Type
from sqlalchemy.ext.declarative import DeclarativeMeta

def generate_custom_id(prefix: str, db: Session, model, field: str = "id") -> str:
    """
    Generate a custom unique ID with a given prefix.
    e.g. PRM-0001, CUS-0002
    """
    latest = (
        db.query(model)
        .order_by(getattr(model, field).desc())
        .first()
    )

    if latest and getattr(latest, field).startswith(prefix):
        try:
            last_num = int(getattr(latest, field).split("-")[1])
        except:
            last_num = 0
    else:
        last_num = 0

    new_id = f"{prefix}-{last_num + 1:04d}"
    return new_id

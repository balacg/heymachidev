from sqlalchemy.orm import Session
from typing import Type
from sqlalchemy.ext.declarative import DeclarativeMeta

def generate_custom_id(prefix: str, db: Session, model, field: str = "id") -> str:
    """
    Generate a custom unique ID with a given prefix.
    Works with any prefix like 'IND', 'SCAT', 'PROD' etc.
    E.g., PROD-0001, SCAT-0025, etc.
    """
    latest = (
        db.query(model)
        .filter(getattr(model, field).like(f"{prefix}-%"))
        .order_by(getattr(model, field).desc())
        .first()
    )

    if latest:
        try:
            # Always get last numeric part after final '-'
            last_num = int(getattr(latest, field).rsplit("-", 1)[-1])
        except:
            last_num = 0
    else:
        last_num = 0

    new_id = f"{prefix}-{last_num + 1:04d}"
    return new_id

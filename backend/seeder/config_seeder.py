# backend/seeder/config_seeder.py

from sqlalchemy.orm import Session
from models.config import Config

def seed_token_prefixes(db: Session):
    default_configs = {
        "delivery_token_prefix": "DL",
        "takeaway_token_prefix": "TK"
    }

    for key, value in default_configs.items():
        existing = db.query(Config).filter(Config.key == key).first()
        if existing:
            existing.value = value
        else:
            db.add(Config(key=key, value=value))

    db.commit()

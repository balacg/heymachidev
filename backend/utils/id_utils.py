# heymachi_backend/utils/id_utils.py
from datetime import datetime
from sqlalchemy.orm import Session
from models.config import Config
from models.token_sequence import TokenSequence
from datetime import date


def format_token(prefix: str, seq: int, date: datetime) -> str:
    date_str = date.strftime('%d%m%y')
    return f"{prefix}-{str(seq).zfill(4)}-{date_str}"

def get_config_value(db: Session, key: str, default: str = '') -> str:
    config = db.query(Config).filter(Config.key == key).first()
    return config.value if config else default

def getNextTokenSequence(type_code: str, db: Session) -> int:
    today = date.today()

    # Try to get existing sequence
    record = db.query(TokenSequence).filter(
        TokenSequence.type_code == type_code,
        TokenSequence.date == today
    ).first()

    if record:
        record.sequence += 1
    else:
        record = TokenSequence(type_code=type_code, date=today, sequence=1)
        db.add(record)

    db.commit()
    db.refresh(record)
    return record.sequence


def generateShortToken(typeCode: str, seq: int, date_: date) -> str:
    dateStr = date_.strftime('%d%m%y')
    seqStr = str(seq).zfill(4)
    return f"{typeCode}-{seqStr}-{dateStr}"

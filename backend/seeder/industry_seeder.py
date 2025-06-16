# backend/seeder/industry_seeder.py

from sqlalchemy.orm import Session
from models.industry import Industry

def seed_industries(db: Session):
    industries = [
        {"id": "RES-0001", "name": "Restaurant"},
        {"id": "CLI-0001", "name": "Clinic"},
        {"id": "SAL-0001", "name": "Salon"},
        {"id": "AUT-0001", "name": "Automobile"},
        {"id": "ELC-0001", "name": "Electronics Store"},
    ]

    for entry in industries:
        existing = db.query(Industry).filter(Industry.id == entry["id"]).first()
        if not existing:
            db.add(Industry(**entry))
    db.commit()

# backend/seeder/business_account_seeder.py

from sqlalchemy.orm import Session
from models.business_account import BusinessAccount

def seed_business_accounts(db: Session):
    existing = db.query(BusinessAccount).count()
    if existing > 0:
        print("Business accounts already seeded.")
        return

    accounts = [
        BusinessAccount(
            id="BIZ-0001",
            name="Hey Machi Cafe",
            industry_id="RES-0001",
            owner_id="USR-0001",
            features_enabled={
                "billing": True,
                "loyalty": True,
                "inventory": True
            }
        ),
        BusinessAccount(
            id="BIZ-0002",
            name="Kick Grass",
            industry_id="RES-0001",
            owner_id="USR-0002",
            features_enabled={
                "billing": True,
                "inventory": True
            }
        )
    ]

    db.add_all(accounts)
    db.commit()
    print("Business accounts seeded successfully.")

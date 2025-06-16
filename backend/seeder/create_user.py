# scripts/create_user.py

import sys
import os
sys.path.append(os.path.dirname(os.path.dirname(__file__)))

from passlib.context import CryptContext
from sqlalchemy.orm import Session
from database import SessionLocal
from models.user import User
from models.role import Role
from utils.id_generator import generate_custom_id

# Optional: if not already seeded
BUSINESS_ID = "BIZ-0001"

EMAIL = "balag.work@gmail.com"
USERNAME = "bala"
FULL_NAME = "Bala Machi"
PASSWORD = "machi123"  # known password

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_password(password: str) -> str:
    return pwd_context.hash(password)

def run():
    db: Session = SessionLocal()

    existing_user = db.query(User).filter(User.email == EMAIL).first()
    if existing_user:
        print("❌ User already exists.")
        return

    new_user = User(
        username=USERNAME,
        email=EMAIL,
        full_name=FULL_NAME,
        hashed_password=hash_password(PASSWORD),
        is_active=True,
        is_admin=True,
        business_id=BUSINESS_ID,
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    print("✅ User created successfully:")
    print(f"  Email: {EMAIL}")
    print(f"  Password: {PASSWORD}")
    print(f"  Business ID: {BUSINESS_ID}")


if __name__ == "__main__":
    run()

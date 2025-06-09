# heymachi_backend/seed_master_data.py

from sqlalchemy.orm import Session
from database import SessionLocal, engine
from models import Base
from models.tax import Tax
from models.category import Category
from models.subcategory import Subcategory
from models.unit import Unit

def seed():
    Base.metadata.create_all(bind=engine)
    db: Session = SessionLocal()

    # Seed Taxes
    taxes = [
        Tax(name="GST 5%", rate=5.0),
        Tax(name="GST 12%", rate=12.0),
        Tax(name="GST 18%", rate=18.0),
        Tax(name="GST 28%", rate=28.0),
    ]
    db.add_all(taxes)
    db.commit()

    # Seed Categories
    categories = [
        Category(name="Electronics", gst=taxes[2]),
        Category(name="Groceries", gst=taxes[0]),
        Category(name="Clothing", gst=taxes[1]),
    ]
    db.add_all(categories)
    db.commit()

    # Seed Subcategories
    subcategories = [
        Subcategory(name="Mobile Phones", category=categories[0], gst=taxes[2]),
        Subcategory(name="Vegetables", category=categories[1], gst=taxes[0]),
        Subcategory(name="Men's Wear", category=categories[2], gst=taxes[1]),
    ]
    db.add_all(subcategories)
    db.commit()

    # Seed Units
    units = [
        Unit(name="Kilogram", abbreviation="kg"),
        Unit(name="Liter", abbreviation="ltr"),
        Unit(name="Piece", abbreviation="pcs"),
    ]
    db.add_all(units)
    db.commit()

    db.close()
    print("Master data seeded successfully.")

if __name__ == "__main__":
    seed()

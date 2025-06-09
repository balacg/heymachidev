from sqlalchemy.orm import Session
from database import SessionLocal
from models.product import Product
from models.category import Category
from models.tax import Tax

db: Session = SessionLocal()

def get_or_create_tax(name: str, rate: float) -> Tax:
    tax = db.query(Tax).filter_by(name=name).first()
    if not tax:
        tax = Tax(name=name, rate=rate)
        db.add(tax)
        db.commit()
        db.refresh(tax)
    return tax

def get_or_create_category(name: str, tax: Tax) -> Category:
    category = db.query(Category).filter_by(name=name).first()
    if not category:
        category = Category(name=name, gst_id=tax.id)
        db.add(category)
        db.commit()
        db.refresh(category)
    return category

mock_products = [
    # name, desc, category, price
    ("Pongal", "Hot rice-lentil dish with sambar", "Restaurant", 77),
    ("Masala Dosa", "Stuffed dosa with chutney", "Restaurant", 88),
    ("Chilli Parotta", "Spicy parotta cubes", "Restaurant", 95),
    ("Paneer Biryani", "Flavored rice with paneer", "Restaurant", 120),
    ("Ghee Roast", "Crispy ghee-flavored dosa", "Restaurant", 110),
    ("Mini Idly", "Idlies dipped in sambar", "Restaurant", 65),

    ("iPhone 15", "256GB, Starlight", "Electronics", 89990),
    ("JBL Speaker", "Bluetooth portable speaker", "Electronics", 3999),
    ("HDMI Cable", "2m high-speed cable", "Electronics", 299),
    ("Power Bank", "10000mAh fast charging", "Electronics", 1199),
    ("LED Monitor", "24-inch Full HD", "Electronics", 7999),
    ("USB Hub", "4-port USB 3.0 splitter", "Electronics", 499),

    ("Haircut", "Basic men's haircut", "Salon", 150),
    ("Hair Spa", "Nourishing oil massage", "Salon", 400),
    ("Beard Trim", "Stylish beard grooming", "Salon", 100),
    ("Facial", "Deep cleansing facial", "Salon", 600),
    ("Pedicure", "Foot spa and clean-up", "Salon", 350),
    ("Hair Color", "Ammonia-free coloring", "Salon", 800),

    ("General Checkup", "Vitals and consultation", "Clinic", 200),
    ("Blood Test", "CBC, Sugar, Lipid", "Clinic", 250),
    ("ECG", "Electrocardiogram", "Clinic", 350),
    ("X-Ray", "Chest or limb scan", "Clinic", 500),
    ("Dental Cleaning", "Plaque removal", "Clinic", 700),
    ("Eye Test", "Vision screening", "Clinic", 180),

    ("Aashirvaad Atta 5kg", "Whole wheat flour", "Supermarket", 280),
    ("Amul Milk 1L", "Toned milk", "Supermarket", 60),
    ("Tide Detergent", "2kg power detergent", "Supermarket", 220),
    ("Rice Ponni 10kg", "Boiled rice pack", "Supermarket", 550),
    ("Sunflower Oil 1L", "Refined cooking oil", "Supermarket", 140),
    ("Maggi Noodles", "2-min instant snack", "Supermarket", 15),
]

def seed_products():
    default_gst = get_or_create_tax("GST 5%", 5.0)

    for name, desc, cat_name, price in mock_products:
        if db.query(Product).filter_by(name=name).first():
            continue

        category = get_or_create_category(cat_name, default_gst)

        product = Product(
            name=name,
            price=price,
            category_id=category.id,
            subcategory_id=None,
            gst_id=default_gst.id
        )
        db.add(product)

    db.commit()
    db.close()
    print("✅ Seeded 30 mock products with categories and GST.")

if __name__ == "__main__":
    seed_products()

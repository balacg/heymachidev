# heymachi_backend/db_seed.py

from sqlalchemy.orm import Session
from database import SessionLocal, engine
from models.base import Base
from models.role import Role
from models.tax import Tax
from models.category import Category
from models.subcategory import Subcategory
from models.unit import Unit
from models.product import Product
from models.customer import Customer
from models.vendor import Vendor

def reset_database():
    print("Dropping all tables...")
    Base.metadata.drop_all(bind=engine)
    print("Creating all tables...")
    Base.metadata.create_all(bind=engine)
    print("Tables recreated successfully.")

def seed_roles(db: Session):
    existing_roles = db.query(Role.name).all()
    existing_role_names = set(r[0] for r in existing_roles)

    roles_to_add = []
    for role_data in [
        {"name": "Admin", "description": "Full access to the system"},
        {"name": "Manager", "description": "Manage day-to-day operations"},
        {"name": "Employee", "description": "Basic access"},
    ]:
        if role_data["name"] not in existing_role_names:
            roles_to_add.append(Role(**role_data))

    if roles_to_add:
        db.add_all(roles_to_add)
        db.commit()
        print(f"Inserted roles: {[r.name for r in roles_to_add]}")
    else:
        print("Roles already exist. Skipping insert.")

def seed_taxes(db: Session):
    existing_taxes = db.query(Tax.name).all()
    existing_tax_names = set(t[0] for t in existing_taxes)

    taxes_to_add = []
    for tax_data in [
        {"name": "GST", "rate": 18.0},
        {"name": "VAT", "rate": 5.0},
    ]:
        if tax_data["name"] not in existing_tax_names:
            taxes_to_add.append(Tax(**tax_data))

    if taxes_to_add:
        db.add_all(taxes_to_add)
        db.commit()
        print(f"Inserted taxes: {[t.name for t in taxes_to_add]}")
    else:
        print("Taxes already exist. Skipping insert.")

def seed_categories(db: Session):
    existing_categories = db.query(Category.name).all()
    existing_category_names = set(c[0] for c in existing_categories)

    # Need to get tax objects for GST & VAT
    gst = db.query(Tax).filter(Tax.name == "GST").first()
    vat = db.query(Tax).filter(Tax.name == "VAT").first()

    categories_to_add = []
    for cat_data in [
        {"name": "Electronics", "gst": gst},
        {"name": "Groceries", "gst": vat},
    ]:
        if cat_data["name"] not in existing_category_names:
            categories_to_add.append(Category(name=cat_data["name"], gst=cat_data["gst"]))

    if categories_to_add:
        db.add_all(categories_to_add)
        db.commit()
        print(f"Inserted categories: {[c.name for c in categories_to_add]}")
    else:
        print("Categories already exist. Skipping insert.")

def seed_subcategories(db: Session):
    existing_subcats = db.query(Subcategory.name).all()
    existing_subcat_names = set(s[0] for s in existing_subcats)

    electronics = db.query(Category).filter(Category.name == "Electronics").first()
    groceries = db.query(Category).filter(Category.name == "Groceries").first()
    gst = db.query(Tax).filter(Tax.name == "GST").first()
    vat = db.query(Tax).filter(Tax.name == "VAT").first()

    subcats_to_add = []
    for subcat_data in [
        {"name": "Mobile Phones", "category": electronics, "gst": gst},
        {"name": "Fruits", "category": groceries, "gst": vat},
    ]:
        if subcat_data["name"] not in existing_subcat_names:
            subcats_to_add.append(Subcategory(name=subcat_data["name"], category=subcat_data["category"], gst=subcat_data["gst"]))

    if subcats_to_add:
        db.add_all(subcats_to_add)
        db.commit()
        print(f"Inserted subcategories: {[s.name for s in subcats_to_add]}")
    else:
        print("Subcategories already exist. Skipping insert.")

def seed_units(db: Session):
    existing_units = db.query(Unit.name).all()
    existing_unit_names = set(u[0] for u in existing_units)

    units_to_add = []
    for unit_data in [
        {"name": "Kilogram", "abbreviation": "kg"},
        {"name": "Litre", "abbreviation": "L"},
        {"name": "Piece", "abbreviation": "pc"},
    ]:
        if unit_data["name"] not in existing_unit_names:
            units_to_add.append(Unit(**unit_data))

    if units_to_add:
        db.add_all(units_to_add)
        db.commit()
        print(f"Inserted units: {[u.name for u in units_to_add]}")
    else:
        print("Units already exist. Skipping insert.")

def seed_products(db: Session):
    existing_products = db.query(Product.name).all()
    existing_product_names = set(p[0] for p in existing_products)

    electronics = db.query(Category).filter(Category.name == "Electronics").first()
    groceries = db.query(Category).filter(Category.name == "Groceries").first()
    mobiles = db.query(Subcategory).filter(Subcategory.name == "Mobile Phones").first()
    fruits = db.query(Subcategory).filter(Subcategory.name == "Fruits").first()
    gst = db.query(Tax).filter(Tax.name == "GST").first()

    products_to_add = []
    for prod_data in [
        {"name": "iPhone 14", "price": 999.99, "category": electronics, "subcategory": mobiles, "gst": gst},
        {"name": "Banana", "price": 0.99, "category": groceries, "subcategory": fruits, "gst": gst},
    ]:
        if prod_data["name"] not in existing_product_names:
            products_to_add.append(Product(
                name=prod_data["name"],
                price=prod_data["price"],
                category=prod_data["category"],
                subcategory=prod_data["subcategory"],
                gst=prod_data["gst"],
            ))

    if products_to_add:
        db.add_all(products_to_add)
        db.commit()
        print(f"Inserted products: {[p.name for p in products_to_add]}")
    else:
        print("Products already exist. Skipping insert.")

def seed_customers(db: Session):
    existing_customers = db.query(Customer.name).all()
    existing_customer_names = set(c[0] for c in existing_customers)

    customers_to_add = []
    for cust_data in [
        {"name": "John Doe", "phone": "1234567890", "email": "john@example.com", "gst": None, "address": "123 Elm St"},
        {"name": "Jane Smith", "phone": "0987654321", "email": "jane@example.com", "gst": None, "address": "456 Oak St"},
    ]:
        if cust_data["name"] not in existing_customer_names:
            customers_to_add.append(Customer(**cust_data))

    if customers_to_add:
        db.add_all(customers_to_add)
        db.commit()
        print(f"Inserted customers: {[c.name for c in customers_to_add]}")
    else:
        print("Customers already exist. Skipping insert.")

def seed_vendors(db: Session):
    existing_vendors = db.query(Vendor.name).all()
    existing_vendor_names = set(v[0] for v in existing_vendors)

    vendors_to_add = []
    for vendor_data in [
        {"name": "Acme Supplies", "phone": "1112223333", "email": "contact@acme.com", "gst": None, "address": "789 Maple Ave"},
        {"name": "Best Goods", "phone": "4445556666", "email": "sales@bestgoods.com", "gst": None, "address": "321 Pine St"},
    ]:
        if vendor_data["name"] not in existing_vendor_names:
            vendors_to_add.append(Vendor(**vendor_data))

    if vendors_to_add:
        db.add_all(vendors_to_add)
        db.commit()
        print(f"Inserted vendors: {[v.name for v in vendors_to_add]}")
    else:
        print("Vendors already exist. Skipping insert.")

def main():
    reset_database()
    db = SessionLocal()
    try:
        seed_roles(db)
        seed_taxes(db)
        seed_categories(db)
        seed_subcategories(db)
        seed_units(db)
        seed_products(db)
        seed_customers(db)
        seed_vendors(db)
        print("Seed data inserted successfully.")
    finally:
        db.close()

if __name__ == "__main__":
    main()

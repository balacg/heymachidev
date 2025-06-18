# create_tables.py

import sys
import os

# Append project root to sys.path so imports work
""" sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from heymachi.backend.database import engine, Base
from hm_industries.restaurant.backend.dbmodels.open_order_db import OpenOrderDB

print("Creating tables in DB:", engine.url)
Base.metadata.create_all(bind=engine)
print("Test metadata:", Base.metadata.tables.keys())  """

# test_insert_order.py

from database import SessionLocal
from hm_industries.restaurant.backend.dbmodels.open_order_db import OpenOrderDB
import json

db = SessionLocal()

order = OpenOrderDB(
    dining_mode="DINE_IN",
    table_no="T1",
    pax=2,
    customer_name="Bala",
    status="OPEN",
    items=json.dumps([{"item": "Dosa", "qty": 2, "price": 50}]),
    total_amount=100.0
)

db.add(order)
db.commit()
db.close()
print("Inserted test order!")

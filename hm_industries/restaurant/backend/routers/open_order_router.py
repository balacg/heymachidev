# hm_industries/restaurant/backend/routers/open_order_router.py

from ..bootstrap import *

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db
#from restaurant.backend.dbmodels.open_order_db import OpenOrderDB
from hm_industries.restaurant.backend.dbmodels.open_order_db import OpenOrderDB
from datetime import datetime
from heymachi.backend.utils.id_utils import getNextTokenSequence, format_token

from typing import List, Optional
import json
import uuid

router = APIRouter(prefix="/open-orders", tags=["Open Orders"])

@router.post("/")
def create_open_order(order: dict, db: Session = Depends(get_db)):
    print("🛰️ Received order payload:", order) 
    order_id = order.get("id") or str(uuid.uuid4())
    items = json.dumps(order.get("items", []))

    if order.get("id"):  # Update existing
        existing = db.query(OpenOrderDB).filter(OpenOrderDB.id == order_id).first()
        if not existing:
            raise HTTPException(status_code=404, detail="Order not found")
        existing.dining_mode = order["dining_mode"]
        existing.table_no = order.get("table_no")
        existing.pax = order.get("pax")
        existing.token_no = order.get("token_no")
        existing.customer_name = order.get("customer_name")
        existing.items = items
        existing.total_amount = order["total_amount"]
        db.commit()
        db.refresh(existing)
        return existing.to_dict()
    else:  # New order
        new_order = OpenOrderDB(
            id=order_id,
            dining_mode=order["dining_mode"],
            table_no=order.get("table_no"),
            pax=order.get("pax"),
            token_no=order.get("token_no"),
            customer_name=order.get("customer_name"),
            items=items,
            total_amount=order["total_amount"],
        )
        db.add(new_order)
        db.commit()
        db.refresh(new_order)
        return new_order.to_dict()

@router.get("/", response_model=List[dict])
def get_all_open_orders(db: Session = Depends(get_db)):
    orders = db.query(OpenOrderDB).filter(OpenOrderDB.status == "OPEN").all()
    return [o.to_dict() for o in orders]

@router.get("/{order_id}", response_model=dict)
def get_open_order(order_id: str, db: Session = Depends(get_db)):
    order = db.query(OpenOrderDB).filter(OpenOrderDB.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    return order.to_dict()

@router.delete("/{order_id}")
def cancel_open_order(order_id: str, db: Session = Depends(get_db)):
    order = db.query(OpenOrderDB).filter(OpenOrderDB.id == order_id).first()
    if not order:
        raise HTTPException(status_code=404, detail="Order not found")
    order.status = "CANCELLED"
    db.commit()
    return {"status": "cancelled", "id": order_id}

@router.get("/generate-token/{type_code}")
def generate_token(type_code: str, db: Session = Depends(get_db)):
    token = getNextTokenSequence(type_code, db)
    formatted = format_token(type_code, token, datetime.now())
    return {"token": formatted}

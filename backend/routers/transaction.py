# app/routers/transactions.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from schemas.transaction import TransactionRecord, TransactionPayload
from sqlalchemy import Column, String

from models.transaction import Transaction
from models.billing import Bill
from database import get_db
from utils.id_generator import generate_custom_id
from sqlalchemy.sql import func

line_id = Column(String, unique=True, index=True, default=lambda: generate_custom_id("TXN"))

router = APIRouter(prefix="/transactions", tags=["Transactions"])

@router.get("/")
def list_transactions(db: Session = Depends(get_db)):
    return db.query(Transaction).order_by(Transaction.date.desc()).all()

@router.post("/")
def save_transaction(payload: TransactionPayload, db: Session = Depends(get_db)):
    print("🚨 Bill payload:", payload.bill.dict())
    print("🚨 Items:", [item.dict() for item in payload.bill_items])

    bill_data = payload.bill.dict()
    try:
        bill = Bill(**bill_data)
        db.add(bill)
        db.commit()
        db.refresh(bill)

        for item in payload.bill_items:
            item_data = item.dict(exclude_unset=True, exclude_none=True)

            # Auto-generate line_id if not present
            if not item_data.get("line_id"):
                item_data["line_id"] = generate_custom_id("TXN", db, Transaction)

            record = Transaction(**item_data)
            record.promo_title = bill.promo_title
            record.promo_discount_percentage = bill.promo_discount_percentage
            record.promo_discount_value = bill.promo_discount_value

            db.add(record)

        db.commit()
        return {"status": "success", "items": len(payload.bill_items)}

    except Exception as e:
        db.rollback()
        print("🔥 DB Error:", str(e))
        raise HTTPException(status_code=500, detail=str(e))

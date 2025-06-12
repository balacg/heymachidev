# app/routes/transactions.py

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from schemas.transaction import TransactionRecord, TransactionPayload
from models.transaction import Transaction
from models.billing import Bill
from database import get_db

router = APIRouter(prefix="/transactions", tags=["Transactions"])

@router.get("/")
def list_transactions(db: Session = Depends(get_db)):
    return db.query(Transaction).order_by(Transaction.date.desc()).all()

@router.post("/")
def save_transaction(payload: TransactionPayload, db: Session = Depends(get_db)):
    # Save the main bill
    bill = Bill(**payload.bill.dict())
    db.add(bill)
    db.flush()  # ensures FK constraint passes for child items

    # Save each bill item (transaction record)
    for item in payload.bill_items:
        record = Transaction(**item.dict())
        db.add(record)

    db.commit()
    return {"status": "success", "items": len(payload.bill_items)}

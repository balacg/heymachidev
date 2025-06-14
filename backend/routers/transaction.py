# app/routers/transactions.py

# app/routers/transactions.py

from fastapi import APIRouter, Depends, HTTPException
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
     
    print("🚨 Bill payload:", payload.bill.dict())
    print("🚨 Items:", [item.dict() for item in payload.bill_items])

    # Save the main bill with promo fields
    bill_data = payload.bill.dict()

    print("✅ Final bill_data before insert:", bill_data)

    try:
        # These must be present in the Bill model
        bill = Bill(**bill_data)

        bill.promo_title = bill_data.get("promo_title")
        bill.promo_discount_percentage = bill_data.get("promo_discount_percentage")
        bill.promo_discount_value = bill_data.get("promo_discount_value")

        db.add(bill)
        db.commit()  # Flush is auto-handled
        db.refresh(bill)  # Optional, to reload updated values
        print("🧾 Confirmed in DB:", bill.promo_title)

        # Save each line item
        for item in payload.bill_items:
            item_data = item.dict(exclude_unset=True, exclude_none=True)
            record = Transaction(**item_data)

            # 👇 Add promo values from bill to each transaction record
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
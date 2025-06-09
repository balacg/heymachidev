# heymachi_backend/routers/billing.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime

from database import get_db
from models.billing import Bill, BillItem
from schemas.billing import BillCreate, BillOut

router = APIRouter(
    prefix="/billing",
    tags=["billing"],
)

@router.post("/", response_model=BillOut)
def create_bill(bill_in: BillCreate, db: Session = Depends(get_db)):
    # Calculate subtotal, gst, total
    subtotal = 0.0
    total_gst = 0.0
    items = []

    for item_in in bill_in.items:
        product = db.query(models.product.Product).filter_by(id=item_in.product_id).first()
        if not product:
            raise HTTPException(status_code=404, detail=f"Product id {item_in.product_id} not found")

        price = product.price
        gst_rate = product.gst.rate
        gst_amount = price * item_in.quantity * gst_rate / 100.0
        line_total = price * item_in.quantity

        subtotal += line_total
        total_gst += gst_amount

        bill_item = BillItem(
            product_id=item_in.product_id,
            quantity=item_in.quantity,
            price=price,
            gst_amount=gst_amount,
        )
        items.append(bill_item)

    total_amount = subtotal + total_gst

    new_bill = Bill(
        customer_id=bill_in.customer_id,
        customer_name=bill_in.customer_name,
        customer_phone=bill_in.customer_phone,
        bill_date=datetime.utcnow(),
        payment_mode=bill_in.payment_mode,
        subtotal=subtotal,
        total_gst=total_gst,
        total_amount=total_amount,
        items=items,
    )
    db.add(new_bill)
    db.commit()
    db.refresh(new_bill)
    return new_bill

@router.get("/", response_model=List[BillOut])
def list_bills(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    bills = db.query(Bill).offset(skip).limit(limit).all()
    return bills

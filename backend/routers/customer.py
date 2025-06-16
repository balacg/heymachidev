# heymachi_backend/routers/customer.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.customer import Customer
from schemas.customer import CustomerCreate, CustomerOut, CustomerUpdate
from routers.auth import get_current_user
from models.user import User

router = APIRouter(
    prefix="/customers",
    tags=["customers"],
)

@router.get("/", response_model=List[CustomerOut])
def get_customers(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Customer).filter_by(business_id=current_user.business_id).all()

@router.post("/", response_model=CustomerOut)
def create_customer(
    customer_in: CustomerCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    # ✅ Check if customer already exists for this business (not globally)
    db_customer = db.query(Customer).filter(
        Customer.phone == customer_in.phone,
        Customer.business_id == current_user.business_id
    ).first()

    if db_customer:
        raise HTTPException(status_code=400, detail="Customer with this phone number already exists")

    new_customer = Customer(**customer_in.dict())
    new_customer.business_id = current_user.business_id

    db.add(new_customer)
    db.commit()
    db.refresh(new_customer)
    return new_customer

@router.put("/{customer_id}", response_model=CustomerOut)
def update_customer(
    customer_id: int,
    customer_in: CustomerUpdate,
    db: Session = Depends(get_db)
):
    customer = db.query(Customer).filter(Customer.id == customer_id).first()
    if not customer:
        raise HTTPException(status_code=404, detail="Customer not found")

    # 💡 Check if phone number is changing, and if so, ensure it's unique within the business
    if customer_in.phone and customer_in.phone != customer.phone:
        existing = db.query(Customer).filter(
            Customer.phone == customer_in.phone,
            Customer.business_id == customer.business_id,
            Customer.id != customer_id  # exclude self from the check
        ).first()
        if existing:
            raise HTTPException(status_code=400, detail="Phone number already in use by another customer")

    for field, value in customer_in.dict(exclude_unset=True).items():
        setattr(customer, field, value)

    db.commit()
    db.refresh(customer)
    return customer

@router.delete("/{customer_id}", status_code=204)
def delete_customer(customer_id: int, db: Session = Depends(get_db)):
    customer = db.query(Customer).filter(Customer.id == customer_id).first()
    if not customer:
        raise HTTPException(status_code=404, detail="Customer not found")
    db.delete(customer)
    db.commit()

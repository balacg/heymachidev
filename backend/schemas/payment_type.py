#heymachi_backend/schemas/payment_type.py

from pydantic import BaseModel

class PaymentTypeBase(BaseModel):
    name: str

class PaymentTypeCreate(PaymentTypeBase):
    pass

class PaymentTypeOut(PaymentTypeBase):
    id: int

    class Config:
        orm_mode = True

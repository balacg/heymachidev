# heymachi_backend/routers/product.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.product import Product
from schemas.product import ProductCreate, ProductOut

router = APIRouter(prefix="/products", tags=["products"])

@router.get("/", response_model=List[ProductOut])
def read_products(skip: int = 0, limit: int = 100, db: Session = Depends(get_db)):
    products = (
        db.query(Product)
        .join(Product.category)
        .offset(skip)
        .limit(limit)
        .all()
    )
    return [
        ProductOut(
            id=p.id,
            name=p.name,
            price=p.price,
            category_id=p.category_id,
            subcategory_id=p.subcategory_id,
            gst_id=p.gst_id,
            category_name=p.category.name
        )
        for p in products
    ]

@router.post("/", response_model=ProductOut)
def create_product(product: ProductCreate, db: Session = Depends(get_db)):
    db_product = Product(
        name=product.name,
        price=product.price,
        category_id=product.category_id,
        subcategory_id=product.subcategory_id,
        gst_id=product.gst_id,
    )
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return ProductOut(
        id=db_product.id,
        name=db_product.name,
        price=db_product.price,
        category_id=db_product.category_id,
        subcategory_id=db_product.subcategory_id,
        gst_id=db_product.gst_id,
        category_name=db_product.category.name
    )

@router.put("/{product_id}", response_model=ProductOut)
def update_product(
    product_id: int,
    product_in: ProductCreate,
    db: Session = Depends(get_db),
):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        raise HTTPException(status_code=404, detail="Product not found")
    for field, val in product_in.dict().items():
        setattr(db_product, field, val)
    db.commit()
    db.refresh(db_product)
    return ProductOut(
        id=db_product.id,
        name=db_product.name,
        price=db_product.price,
        category_id=db_product.category_id,
        subcategory_id=db_product.subcategory_id,
        gst_id=db_product.gst_id,
        category_name=db_product.category.name
    )

@router.delete("/{product_id}", status_code=204)
def delete_product(product_id: int, db: Session = Depends(get_db)):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        raise HTTPException(status_code=404, detail="Product not found")
    db.delete(db_product)
    db.commit()
    return

# backend/routers/product.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Product
from schemas import ProductCreate, ProductOut

router = APIRouter(prefix="/products", tags=["Products"])

@router.get("/", response_model=list[ProductOut])
def list_products(db: Session = Depends(get_db)):
    products = db.query(Product).all()
    output = []

    for product in products:
        category_name = product.category.name if product.category else ""
        out = ProductOut(
            id=product.id,
            name=product.name,
            price=product.price,
            category_id=product.category_id,
            subcategory_id=product.subcategory_id,
            gst_id=product.gst_id,
            category_name=category_name
        )
        output.append(out)

    return output


@router.post("/", response_model=ProductOut)
def create(product: ProductCreate, db: Session = Depends(get_db)):
    new_product = Product(**product.dict())
    db.add(new_product)
    db.commit()
    db.refresh(new_product)
    return ProductOut(
        id=new_product.id,
        name=new_product.name,
        price=new_product.price,
        category_id=new_product.category_id,
        subcategory_id=new_product.subcategory_id,
        gst_id=new_product.gst_id,
        category_name=new_product.category.name if new_product.category else ""
    )


@router.put("/{product_id}", response_model=ProductOut)
def update(product_id: int, product: ProductCreate, db: Session = Depends(get_db)):
    db_product = db.query(Product).filter(Product.id == product_id).first()
    if not db_product:
        raise HTTPException(status_code=404, detail="Product not found")
    for field, value in product.dict().items():
        setattr(db_product, field, value)
    db.commit()
    db.refresh(db_product)
    return ProductOut(
        id=db_product.id,
        name=db_product.name,
        price=db_product.price,
        category_id=db_product.category_id,
        subcategory_id=db_product.subcategory_id,
        gst_id=db_product.gst_id,
        category_name=db_product.category.name if db_product.category else ""
    )


@router.delete("/{product_id}")
def delete(product_id: int, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    db.delete(product)
    db.commit()
    return {"message": "Product deleted"}

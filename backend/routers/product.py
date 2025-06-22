# backend/routers/product.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
from database import get_db
from models.product import Product
from schemas.product import ProductCreate, ProductUpdate, ProductOut
from routers.auth import get_current_user
from models.user import User
from utils.id_generator import generate_custom_id
from models.subcategory import Subcategory
from models.tax import Tax
from models.category import Category
from models.tag import Tag
from models.product_tag import product_tags


router = APIRouter()


@router.get("/", response_model=List[ProductOut])
def get_products(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    stmt = (
        db.query(
            Product.id,
            Product.name,
            Product.price,
            Product.category_id,
            Product.subcategory_id,
            Product.gst_id,
            Product.unit_id,
            Product.is_active,
            Product.business_id,
            Category.name.label("category_name"),
            Subcategory.name.label("subcategory_name"),
            Tax.rate.label("gst_rate"),
        )
        .outerjoin(Category, Product.category_id == Category.id)
        .outerjoin(Subcategory, Product.subcategory_id == Subcategory.id)
        .outerjoin(Tax, Product.gst_id == Tax.id)
        .filter(Product.business_id == current_user.business_id)
    )
    result = stmt.all()
    products = []
    for row in result:
        row_dict = dict(row._mapping)
        product = db.query(Product).filter_by(id=row_dict["id"]).first()
        row_dict["tags"] = [{"id": tag.id, "tag_type": tag.tag_type, "tag_value": tag.tag_value, "business_id": tag.business_id,} for tag in product.tags]
        row_dict["tag_ids"] = [tag.id for tag in product.tags]
        products.append(row_dict)
    return products


@router.post("/", response_model=ProductOut)
def create_product(payload: ProductCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    existing = db.query(Product).filter_by(name=payload.name, business_id=current_user.business_id).first()
    if existing:
        raise HTTPException(status_code=409, detail="Product with the same name already exists")

    product_data = payload.dict()
    tag_ids = product_data.pop("tag_ids", [])

    new_item = Product(
        id=generate_custom_id("PRD", db, Product),
        **product_data
    )
    new_item.business_id = current_user.business_id
    new_item.tags = db.query(Tag).filter(Tag.id.in_(tag_ids)).all()

    db.add(new_item)
    db.commit()
    db.refresh(new_item)
    return new_item


@router.put("/{product_id}", response_model=ProductOut)
def update_product(product_id: str, updated: ProductUpdate, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")

    update_data = updated.dict(exclude_unset=True)
    tag_ids = update_data.pop("tag_ids", None)

    for key, value in update_data.items():
        setattr(product, key, value)

    if tag_ids is not None:
        product.tags = db.query(Tag).filter(Tag.id.in_(tag_ids)).all()

    db.commit()
    db.refresh(product)
    return product


@router.delete("/{product_id}")
def delete_product(product_id: str, db: Session = Depends(get_db)):
    product = db.query(Product).filter(Product.id == product_id).first()
    if not product:
        raise HTTPException(status_code=404, detail="Product not found")
    db.delete(product)
    db.commit()
    return {"message": "Product deleted successfully"}

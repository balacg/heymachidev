# backend/routers/restaurant/menu_item.py

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db
from models.restaurant.menu_item import MenuItem
from schemas.restaurant.menu_item import MenuItemCreate, MenuItemUpdate, MenuItemOut
from typing import List

router = APIRouter()

@router.get("/restaurant/menu-items", response_model=List[MenuItemOut])
def get_menu_items(db: Session = Depends(get_db)):
    return db.query(MenuItem).all()

@router.post("/restaurant/menu-items", response_model=MenuItemOut)
def create_menu_item(item: MenuItemCreate, db: Session = Depends(get_db)):
    db_item = MenuItem(**item.dict())
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item

@router.put("/restaurant/menu-items/{item_id}", response_model=MenuItemOut)
def update_menu_item(item_id: str, updated: MenuItemUpdate, db: Session = Depends(get_db)):
    item = db.query(MenuItem).filter(MenuItem.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    for field, value in updated.dict().items():
        setattr(item, field, value)
    db.commit()
    db.refresh(item)
    return item

@router.delete("/restaurant/menu-items/{item_id}")
def delete_menu_item(item_id: str, db: Session = Depends(get_db)):
    item = db.query(MenuItem).filter(MenuItem.id == item_id).first()
    if not item:
        raise HTTPException(status_code=404, detail="Item not found")
    db.delete(item)
    db.commit()
    return {"message": "Deleted successfully"}

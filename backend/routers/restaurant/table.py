
# backend/routers/restaurant/table_router.py

from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from typing import List

from database import get_db
from models.restaurant.table import RestaurantTable
from schemas.restaurant.table import TableCreate, TableUpdate, TableOut

router = APIRouter()

@router.get("/restaurant/tables", response_model=List[TableOut])
def get_tables(db: Session = Depends(get_db)):
    return db.query(RestaurantTable).all()

@router.post("/restaurant/tables", response_model=TableOut)
def create_table(table: TableCreate, db: Session = Depends(get_db)):
    new_table = RestaurantTable(**table.dict())
    db.add(new_table)
    db.commit()
    db.refresh(new_table)
    return new_table

@router.put("/restaurant/tables/{table_id}", response_model=TableOut)
def update_table(table_id: str, updated: TableUpdate, db: Session = Depends(get_db)):
    table = db.query(RestaurantTable).filter(RestaurantTable.id == table_id).first()
    if not table:
        raise HTTPException(status_code=404, detail="Table not found")
    for key, value in updated.dict().items():
        setattr(table, key, value)
    db.commit()
    db.refresh(table)
    return table

@router.delete("/restaurant/tables/{table_id}")
def delete_table(table_id: str, db: Session = Depends(get_db)):
    table = db.query(RestaurantTable).filter(RestaurantTable.id == table_id).first()
    if not table:
        raise HTTPException(status_code=404, detail="Table not found")
    db.delete(table)
    db.commit()
    return {"message": "Table deleted successfully"}

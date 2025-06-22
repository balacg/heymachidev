#heymachi_backend/routers/tag.py

from typing import List
from backend.core.security import get_current_user
from models.user import User
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from backend.models.tag import Tag
from backend.schemas.tag import TagCreate, TagOut
from database import get_db

router = APIRouter(prefix="/tags", tags=["Tags"])

@router.get("/", response_model=List[TagOut])
def get_tags(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Tag).filter(Tag.business_id == current_user.business_id).all()

@router.post("/", response_model=TagOut)
def create_tag(tag: TagCreate, db: Session = Depends(get_db)):
    db_tag = Tag(**tag.dict())
    db.add(db_tag)
    db.commit()
    db.refresh(db_tag)
    return db_tag

@router.put("/{id}/", response_model=TagOut)
def update_tag(id: int, tag: TagCreate, db: Session = Depends(get_db)):
    db_tag = db.query(Tag).filter(Tag.id == id).first()
    if not db_tag:
        raise HTTPException(status_code=404, detail="Tag not found")

    for field, value in tag.dict().items():
        setattr(db_tag, field, value)

    db.commit()
    db.refresh(db_tag)
    return db_tag

@router.delete("/{id}")
def delete_tag(id: int, db: Session = Depends(get_db)):
    tag = db.query(Tag).filter(Tag.id == id).first()
    if not tag:
        raise HTTPException(status_code=404, detail="Tag not found")
    db.delete(tag)
    db.commit()
    return {"message": "Tag deleted"}
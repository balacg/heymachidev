# heymachi_backend/routers/role.py

from fastapi import APIRouter, HTTPException, Depends, status
from sqlalchemy.orm import Session
from typing import List, Optional
from pydantic import BaseModel
from database import get_db
from models.role import Role
from core.security import get_current_user  # ✅ or wherever your auth lives
from models.user import User
from schemas.role import RoleCreate, RoleUpdate, RoleOut

router = APIRouter(prefix="/roles", tags=["roles"])

@router.get("/", response_model=List[RoleOut])
def read_roles(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    return db.query(Role).filter_by(business_id=current_user.business_id).all()


@router.get("/{role_id}", response_model=RoleOut)
def read_role(role_id: int, db: Session = Depends(get_db)):
    role = db.query(Role).filter(Role.id == role_id).first()
    if not role:
        raise HTTPException(status_code=404, detail="Role not found")
    return role

@router.post("/", response_model=RoleOut, status_code=status.HTTP_201_CREATED)
def create_role(
    role: RoleCreate,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    existing = db.query(Role).filter_by(
        name=role.name, business_id=current_user.business_id
    ).first()
    if existing:
        raise HTTPException(status_code=400, detail="Role name already exists")

    new_role = Role(
        name=role.name,
        description=role.description,
        business_id=current_user.business_id
    )
    db.add(new_role)
    db.commit()
    db.refresh(new_role)
    return new_role


@router.put("/{role_id}", response_model=RoleOut)
def update_role(role_id: int, role_in: RoleUpdate, db: Session = Depends(get_db)):
    role = db.query(Role).filter(Role.id == role_id).first()
    if not role:
        raise HTTPException(status_code=404, detail="Role not found")
    for field, value in role_in.dict(exclude_unset=True).items():
        setattr(role, field, value)
    db.commit()
    db.refresh(role)
    return role

@router.delete("/{role_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_role(role_id: int, db: Session = Depends(get_db)):
    role = db.query(Role).filter(Role.id == role_id).first()
    if not role:
        raise HTTPException(status_code=404, detail="Role not found")
    db.delete(role)
    db.commit()

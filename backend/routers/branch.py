# backend/routers/branch.py

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from schemas.branch import BranchCreate, BranchOut, BranchUpdate    
from models.branch import Branch
from database import get_db
from utils.id_generator import generate_custom_id
from core.security import get_current_user 
from models.user import User

router = APIRouter(prefix="/branches", tags=["Branches"])

@router.post("/", response_model=BranchOut)
def create_branch(payload: BranchCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    new_branch = Branch(
        id=generate_custom_id("BR", db, Branch),
        business_id=current_user.business_id,
        **payload.dict()
    )
    db.add(new_branch)
    db.commit()
    db.refresh(new_branch)
    return new_branch

@router.get("/", response_model=list[BranchOut])
def get_all_branches(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return db.query(Branch).filter_by(business_id=current_user.business_id).all()

@router.get("/default")
def get_default_branch(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    branch = db.query(Branch).filter_by(business_id=current_user.business_id).first()
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    return {
        "id": branch.id,
        "state": branch.state,
        "name": branch.name
    }

@router.put("/{branch_id}", response_model=BranchOut)
def update_branch(branch_id: str, payload: BranchUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    branch = db.query(Branch).filter_by(id=branch_id, business_id=current_user.business_id).first()
    if not branch:
        raise HTTPException(status_code=404, detail="Branch not found")
    
    for field, value in payload.dict(exclude_unset=True).items():
        setattr(branch, field, value)

    db.commit()
    db.refresh(branch)
    return branch
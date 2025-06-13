from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models.business_profile import BusinessProfile
from schemas.business_profile import BusinessProfileOut, BusinessProfileUpdate

router = APIRouter(prefix="/business-profile", tags=["business"])

@router.get("/", response_model=BusinessProfileOut)
def get_profile(db: Session = Depends(get_db)):
    profile = db.query(BusinessProfile).first()
    if not profile:
        raise HTTPException(status_code=404, detail="Business profile not found")
    return profile

@router.put("/", response_model=BusinessProfileOut)
def update_profile(payload: BusinessProfileUpdate, db: Session = Depends(get_db)):
    profile = db.query(BusinessProfile).first()
    if not profile:
        profile = BusinessProfile(**payload.dict())
        db.add(profile)
    else:
        for key, value in payload.dict().items():
            setattr(profile, key, value)
    db.commit()
    db.refresh(profile)
    return profile

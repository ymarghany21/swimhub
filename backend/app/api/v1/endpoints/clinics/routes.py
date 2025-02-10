from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from db import get_db
from . import schemas, models

router = APIRouter(prefix="/clinics", tags=["Clinics"])

# Create a Clinic
@router.post("/", response_model=schemas.ClinicResponse)
def create_clinic(clinic: schemas.ClinicCreate, db: Session = Depends(get_db)):
    db_clinic = models.Clinic(**clinic.dict())
    db.add(db_clinic)
    db.commit()
    db.refresh(db_clinic)
    return db_clinic

# Get All Clinics
@router.get("/", response_model=list[schemas.ClinicResponse])
def get_clinics(db: Session = Depends(get_db)):
    return db.query(models.Clinic).all()

# Get Single Clinic
@router.get("/{clinic_id}", response_model=schemas.ClinicResponse)
def get_clinic(clinic_id: int, db: Session = Depends(get_db)):
    clinic = db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()
    if not clinic:
        raise HTTPException(status_code=404, detail="Clinic not found")
    return clinic

# Update Clinic
@router.put("/{clinic_id}", response_model=schemas.ClinicResponse)
def update_clinic(clinic_id: int, clinic_data: schemas.ClinicUpdate, db: Session = Depends(get_db)):
    clinic = db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()
    if not clinic:
        raise HTTPException(status_code=404, detail="Clinic not found")
    
    for key, value in clinic_data.dict(exclude_unset=True).items():
        setattr(clinic, key, value)
    
    db.commit()
    db.refresh(clinic)
    return clinic

# Delete Clinic
@router.delete("/{clinic_id}")
def delete_clinic(clinic_id: int, db: Session = Depends(get_db)):
    clinic = db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()
    if not clinic:
        raise HTTPException(status_code=404, detail="Clinic not found")
    
    db.delete(clinic)
    db.commit()
    return {"message": "Clinic deleted successfully"}

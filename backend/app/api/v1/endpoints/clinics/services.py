from sqlalchemy.orm import Session
from . import models, schemas

def create_clinic(db: Session, clinic: schemas.ClinicCreate):
    db_clinic = models.Clinic(**clinic.dict())
    db.add(db_clinic)
    db.commit()
    db.refresh(db_clinic)
    return db_clinic

def get_clinic(db: Session, clinic_id: int):
    return db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()

def update_clinic(db: Session, clinic_id: int, clinic_data: schemas.ClinicUpdate):
    clinic = db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()
    if not clinic:
        return None
    
    for key, value in clinic_data.dict(exclude_unset=True).items():
        setattr(clinic, key, value)
    
    db.commit()
    db.refresh(clinic)
    return clinic

def delete_clinic(db: Session, clinic_id: int):
    clinic = db.query(models.Clinic).filter(models.Clinic.clinic_id == clinic_id).first()
    if not clinic:
        return None
    
    db.delete(clinic)
    db.commit()
    return True

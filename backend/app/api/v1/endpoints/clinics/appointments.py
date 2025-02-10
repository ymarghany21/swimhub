from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from db import get_db
from schemas import schemas
from models import models

@router.post("/{clinic_id}/appointments", response_model=schemas.ClinicAppointmentResponse)
def book_appointment(clinic_id: int, appointment: schemas.ClinicAppointmentCreate, db: Session = Depends(get_db)):
    db_appointment = models.ClinicAppointment(**appointment.dict(), clinic_id=clinic_id)
    db.add(db_appointment)
    db.commit()
    db.refresh(db_appointment)
    return db_appointment

# Get Appointments for a Clinic
@router.get("/{clinic_id}/appointments", response_model=list[schemas.ClinicAppointmentResponse])
def get_appointments(clinic_id: int, db: Session = Depends(get_db)):
    return db.query(models.ClinicAppointment).filter(models.ClinicAppointment.clinic_id == clinic_id).all()

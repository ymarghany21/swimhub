# Get Available Beds
@router.get("/{clinic_id}/beds", response_model=list[schemas.ClinicBedResponse])
def get_available_beds(clinic_id: int, db: Session = Depends(get_db)):
    return db.query(models.ClinicBed).filter(models.ClinicBed.clinic_id == clinic_id, models.ClinicBed.status == 'available').all()

# Update Bed Status
@router.put("/beds/{bed_id}", response_model=schemas.ClinicBedResponse)
def update_bed_status(bed_id: int, bed_data: schemas.ClinicBedUpdate, db: Session = Depends(get_db)):
    bed = db.query(models.ClinicBed).filter(models.ClinicBed.bed_id == bed_id).first()
    if not bed:
        raise HTTPException(status_code=404, detail="Bed not found")

    bed.status = bed_data.status
    db.commit()
    db.refresh(bed)
    return bed

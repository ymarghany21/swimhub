# Create Branch
@router.post("/branches/", response_model=schemas.ClinicBranchResponse)
def create_branch(branch: schemas.ClinicBranchCreate, db: Session = Depends(get_db)):
    db_branch = models.ClinicBranch(**branch.dict())
    db.add(db_branch)
    db.commit()
    db.refresh(db_branch)
    return db_branch

# Get All Branches for a Clinic
@router.get("/{clinic_id}/branches", response_model=list[schemas.ClinicBranchResponse])
def get_branches(clinic_id: int, db: Session = Depends(get_db)):
    return db.query(models.ClinicBranch).filter(models.ClinicBranch.entity_id == clinic_id).all()

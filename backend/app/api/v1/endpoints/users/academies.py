from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Academy  # Import the Academy model
from app.schemas.profiles.academy import AcademyInfo, AcademyResponse

router = APIRouter(prefix="/academies", tags=["academies"])

@router.post("/", response_model=AcademyResponse)
def create_academy(academy: AcademyInfo, db: Session = Depends(get_db)):
    """
    Create a new academy.
    
    Args:
        academy (AcademyInfo): The academy data.
        db (Session): The database session.
    
    Returns:
        AcademyResponse: The created academy's data.
    
    Raises:
        HTTPException: If the business license URL is invalid or the user ID is invalid.
    """
    # Create a new academy object
    new_academy = Academy(
        specialty=academy.specialty,
        coach_count=academy.coach_count,
        business_license_url=academy.business_license_url,
        tax_number=academy.tax_number,
        contact_email=academy.contact_email,
        website_url=academy.website_url,
        contact_phone_number=academy.contact_phone_number,
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new academy to the database
    db.add(new_academy)
    db.commit()
    db.refresh(new_academy)
    
    # Return the academy's data in the AcademyResponse format
    return new_academy

@router.get("/{academy_id}", response_model=AcademyResponse)
def get_academy(academy_id: int, db: Session = Depends(get_db)):
    """
    Get an academy by ID.
    
    Args:
        academy_id (int): The ID of the academy.
        db (Session): The database session.
    
    Returns:
        AcademyResponse: The academy's data.
    
    Raises:
        HTTPException: If the academy is not found.
    """
    academy = db.query(Academy).filter(Academy.id == academy_id).first()
    if not academy:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Academy not found."
        )
    return academy

@router.get("/", response_model=list[AcademyResponse])
def get_all_academies(db: Session = Depends(get_db)):
    """
    Get all academies.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[AcademyResponse]: A list of all academies.
    """
    academies = db.query(Academy).all()
    return academies

@router.put("/{academy_id}", response_model=AcademyResponse)
def update_academy(academy_id: int, academy: AcademyInfo, db: Session = Depends(get_db)):
    """
    Update an academy by ID.
    
    Args:
        academy_id (int): The ID of the academy.
        academy (AcademyInfo): The updated academy data.
        db (Session): The database session.
    
    Returns:
        AcademyResponse: The updated academy's data.
    
    Raises:
        HTTPException: If the academy is not found.
    """
    # Find the academy to update
    academy_to_update = db.query(Academy).filter(Academy.id == academy_id).first()
    if not academy_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Academy not found."
        )
    
    # Update the academy's data
    academy_to_update.specialty = academy.specialty
    academy_to_update.coach_count = academy.coach_count
    academy_to_update.business_license_url = academy.business_license_url
    academy_to_update.tax_number = academy.tax_number
    academy_to_update.contact_email = academy.contact_email
    academy_to_update.website_url = academy.website_url
    academy_to_update.contact_phone_number = academy.contact_phone_number
    
    # Commit the changes to the database
    db.commit()
    db.refresh(academy_to_update)
    
    # Return the updated academy's data
    return academy_to_update

@router.delete("/{academy_id}")
def delete_academy(academy_id: int, db: Session = Depends(get_db)):
    """
    Delete an academy by ID.
    
    Args:
        academy_id (int): The ID of the academy.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the academy is not found.
    """
    # Find the academy to delete
    academy_to_delete = db.query(Academy).filter(Academy.id == academy_id).first()
    if not academy_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Academy not found."
        )
    
    # Delete the academy from the database
    db.delete(academy_to_delete)
    db.commit()
    
    return {"message": "Academy deleted successfully."}
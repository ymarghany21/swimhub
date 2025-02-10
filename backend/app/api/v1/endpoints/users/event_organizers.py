from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Organizer  # Import the Organizer model
from app.schemas.profiles.organizer import organizerInfo, OrganizerResponse  # Import the schemas

router = APIRouter(prefix="/organizers", tags=["organizers"])

@router.post("/", response_model=OrganizerResponse)
def create_organizer(organizer: organizerInfo, db: Session = Depends(get_db)):
    """
    Create a new organizer.
    
    Args:
        organizer (organizerInfo): The organizer data.
        db (Session): The database session.
    
    Returns:
        OrganizerResponse: The created organizer's data.
    
    Raises:
        HTTPException: If the user ID is invalid.
    """
    # Create a new organizer object
    new_organizer = Organizer(
        organization_name=organizer.organization_name,
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new organizer to the database
    db.add(new_organizer)
    db.commit()
    db.refresh(new_organizer)
    
    # Return the organizer's data in the OrganizerResponse format
    return new_organizer

@router.get("/{organizer_id}", response_model=OrganizerResponse)
def get_organizer(organizer_id: int, db: Session = Depends(get_db)):
    """
    Get an organizer by ID.
    
    Args:
        organizer_id (int): The ID of the organizer.
        db (Session): The database session.
    
    Returns:
        OrganizerResponse: The organizer's data.
    
    Raises:
        HTTPException: If the organizer is not found.
    """
    organizer = db.query(Organizer).filter(Organizer.id == organizer_id).first()
    if not organizer:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Organizer not found."
        )
    return organizer

@router.get("/", response_model=list[OrganizerResponse])
def get_all_organizers(db: Session = Depends(get_db)):
    """
    Get all organizers.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[OrganizerResponse]: A list of all organizers.
    """
    organizers = db.query(Organizer).all()
    return organizers

@router.put("/{organizer_id}", response_model=OrganizerResponse)
def update_organizer(organizer_id: int, organizer: organizerInfo, db: Session = Depends(get_db)):
    """
    Update an organizer by ID.
    
    Args:
        organizer_id (int): The ID of the organizer.
        organizer (organizerInfo): The updated organizer data.
        db (Session): The database session.
    
    Returns:
        OrganizerResponse: The updated organizer's data.
    
    Raises:
        HTTPException: If the organizer is not found.
    """
    # Find the organizer to update
    organizer_to_update = db.query(Organizer).filter(Organizer.id == organizer_id).first()
    if not organizer_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Organizer not found."
        )
    
    # Update the organizer's data
    organizer_to_update.organization_name = organizer.organization_name
    
    # Commit the changes to the database
    db.commit()
    db.refresh(organizer_to_update)
    
    # Return the updated organizer's data
    return organizer_to_update

@router.delete("/{organizer_id}")
def delete_organizer(organizer_id: int, db: Session = Depends(get_db)):
    """
    Delete an organizer by ID.
    
    Args:
        organizer_id (int): The ID of the organizer.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the organizer is not found.
    """
    # Find the organizer to delete
    organizer_to_delete = db.query(Organizer).filter(Organizer.id == organizer_id).first()
    if not organizer_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Organizer not found."
        )
    
    # Delete the organizer from the database
    db.delete(organizer_to_delete)
    db.commit()
    
    return {"message": "Organizer deleted successfully."}
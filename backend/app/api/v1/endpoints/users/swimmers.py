from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Swimmer  # Import the Swimmer model
from app.schemas.profiles.swimmer import SwimmerInfo, SwimmerResponse  # Import the schemas
from datetime import datetime

router = APIRouter(prefix="/swimmers", tags=["swimmers"])

@router.post("/", response_model=SwimmerResponse)
def create_swimmer(swimmer: SwimmerInfo, db: Session = Depends(get_db)):
    """
    Create a new swimmer.
    
    Args:
        swimmer (SwimmerInfo): The swimmer data.
        db (Session): The database session.
    
    Returns:
        SwimmerResponse: The created swimmer's data.
    
    Raises:
        HTTPException: If the user ID is invalid.
    """
    # Create a new swimmer object
    new_swimmer = Swimmer(
        skill_level=swimmer.skill_level,
        goals=swimmer.goals,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
        age_group=swimmer.age_group,
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new swimmer to the database
    db.add(new_swimmer)
    db.commit()
    db.refresh(new_swimmer)
    
    # Return the swimmer's data in the SwimmerResponse format
    return new_swimmer

@router.get("/{swimmer_id}", response_model=SwimmerResponse)
def get_swimmer(swimmer_id: int, db: Session = Depends(get_db)):
    """
    Get a swimmer by ID.
    
    Args:
        swimmer_id (int): The ID of the swimmer.
        db (Session): The database session.
    
    Returns:
        SwimmerResponse: The swimmer's data.
    
    Raises:
        HTTPException: If the swimmer is not found.
    """
    swimmer = db.query(Swimmer).filter(Swimmer.id == swimmer_id).first()
    if not swimmer:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Swimmer not found."
        )
    return swimmer

@router.get("/", response_model=list[SwimmerResponse])
def get_all_swimmers(db: Session = Depends(get_db)):
    """
    Get all swimmers.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[SwimmerResponse]: A list of all swimmers.
    """
    swimmers = db.query(Swimmer).all()
    return swimmers

@router.put("/{swimmer_id}", response_model=SwimmerResponse)
def update_swimmer(swimmer_id: int, swimmer: SwimmerInfo, db: Session = Depends(get_db)):
    """
    Update a swimmer by ID.
    
    Args:
        swimmer_id (int): The ID of the swimmer.
        swimmer (SwimmerInfo): The updated swimmer data.
        db (Session): The database session.
    
    Returns:
        SwimmerResponse: The updated swimmer's data.
    
    Raises:
        HTTPException: If the swimmer is not found.
    """
    # Find the swimmer to update
    swimmer_to_update = db.query(Swimmer).filter(Swimmer.id == swimmer_id).first()
    if not swimmer_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Swimmer not found."
        )
    
    # Update the swimmer's data
    swimmer_to_update.skill_level = swimmer.skill_level
    swimmer_to_update.goals = swimmer.goals
    swimmer_to_update.age_group = swimmer.age_group
    swimmer_to_update.updated_at = datetime.utcnow()
    
    # Commit the changes to the database
    db.commit()
    db.refresh(swimmer_to_update)
    
    # Return the updated swimmer's data
    return swimmer_to_update

@router.delete("/{swimmer_id}")
def delete_swimmer(swimmer_id: int, db: Session = Depends(get_db)):
    """
    Delete a swimmer by ID.
    
    Args:
        swimmer_id (int): The ID of the swimmer.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the swimmer is not found.
    """
    # Find the swimmer to delete
    swimmer_to_delete = db.query(Swimmer).filter(Swimmer.id == swimmer_id).first()
    if not swimmer_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Swimmer not found."
        )
    
    # Delete the swimmer from the database
    db.delete(swimmer_to_delete)
    db.commit()
    
    return {"message": "Swimmer deleted successfully."}
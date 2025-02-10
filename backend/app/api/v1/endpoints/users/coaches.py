from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Coach  
from app.schemas.profiles.coach import CoachInfo, CoachResponse  
from datetime import datetime

router = APIRouter(prefix="/coaches", tags=["coaches"])

@router.post("/", response_model=CoachResponse)
def create_coach(coach: CoachInfo, db: Session = Depends(get_db)):
    """
    Create a new coach.
    
    Args:
        coach (CoachInfo): The coach data.
        db (Session): The database session.
    
    Returns:
        CoachResponse: The created coach's data.
    
    Raises:
        HTTPException: If the user ID is invalid.
    """
    # Create a new coach object
    new_coach = Coach(
        speciality=coach.speciality,
        experience_years=coach.experience_years,
        description=coach.description,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new coach to the database
    db.add(new_coach)
    db.commit()
    db.refresh(new_coach)
    
    # Return the coach's data in the CoachResponse format
    return new_coach

@router.get("/{coach_id}", response_model=CoachResponse)
def get_coach(coach_id: int, db: Session = Depends(get_db)):
    """
    Get a coach by ID.
    
    Args:
        coach_id (int): The ID of the coach.
        db (Session): The database session.
    
    Returns:
        CoachResponse: The coach's data.
    
    Raises:
        HTTPException: If the coach is not found.
    """
    coach = db.query(Coach).filter(Coach.id == coach_id).first()
    if not coach:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Coach not found."
        )
    return coach

@router.get("/", response_model=list[CoachResponse])
def get_all_coaches(db: Session = Depends(get_db)):
    """
    Get all coaches.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[CoachResponse]: A list of all coaches.
    """
    coaches = db.query(Coach).all()
    return coaches

@router.put("/{coach_id}", response_model=CoachResponse)
def update_coach(coach_id: int, coach: CoachInfo, db: Session = Depends(get_db)):
    """
    Update a coach by ID.
    
    Args:
        coach_id (int): The ID of the coach.
        coach (CoachInfo): The updated coach data.
        db (Session): The database session.
    
    Returns:
        CoachResponse: The updated coach's data.
    
    Raises:
        HTTPException: If the coach is not found.
    """
    # Find the coach to update
    coach_to_update = db.query(Coach).filter(Coach.id == coach_id).first()
    if not coach_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Coach not found."
        )
    
    # Update the coach's data
    coach_to_update.speciality = coach.speciality
    coach_to_update.experience_years = coach.experience_years
    coach_to_update.description = coach.description
    coach_to_update.updated_at = datetime.utcnow()
    
    # Commit the changes to the database
    db.commit()
    db.refresh(coach_to_update)
    
    # Return the updated coach's data
    return coach_to_update

@router.delete("/{coach_id}")
def delete_coach(coach_id: int, db: Session = Depends(get_db)):
    """
    Delete a coach by ID.
    
    Args:
        coach_id (int): The ID of the coach.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the coach is not found.
    """
    # Find the coach to delete
    coach_to_delete = db.query(Coach).filter(Coach.id == coach_id).first()
    if not coach_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Coach not found."
        )
    
    # Delete the coach from the database
    db.delete(coach_to_delete)
    db.commit()
    
    return {"message": "Coach deleted successfully."}


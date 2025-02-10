from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import models
from app.schemas.profiles.user import userRegister, userLogin, UserResponse
from passlib.context import CryptContext
from datetime import datetime
from typing import Type

# Password hashing setup
pwd_context: Type[CryptContext] = CryptContext(schemes=["bcrypt"], deprecated="auto")

router = APIRouter()

def verify_password(plain_password: str, hashed_password: str) -> bool:
    """Verify that the plain password matches the hashed password."""
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password: str) -> str:
    """Hash the password using bcrypt."""
    return pwd_context.hash(password)

@router.post("/register", response_model=UserResponse)
def register_user(user: userRegister, db: Session = Depends(get_db)):
    """
    Register a new user.
    
    Args:
        user (userRegister): The user registration data.
        db (Session): The database session.
    
    Returns:
        UserResponse: The registered user's data.
    
    Raises:
        HTTPException: If the email is already registered.
    """
    # Check if the email is already registered
    existing_user = db.query(models.User).filter(models.User.email == user.email).first()
    if existing_user:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Email already registered."
        )
    
    # Hash the user's password
    hashed_password = get_password_hash(user.password)
    
    # Create a new user object
    new_user = models.User(
        email=user.email,
        hashed_password=hashed_password,
        full_name=user.full_name,
        created_at=datetime.utcnow()
    )
    
    # Add the new user to the database
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    # Return the user's data in the UserResponse format
    return new_user
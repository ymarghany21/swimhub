from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Vendor  # Import the Vendor model
from app.schemas.profiles.vendor import VendorInfo, VendorResponse  # Import the schemas

router = APIRouter(prefix="/vendors", tags=["vendors"])

@router.post("/", response_model=VendorResponse)
def create_vendor(vendor: VendorInfo, db: Session = Depends(get_db)):
    """
    Create a new vendor.
    
    Args:
        vendor (VendorInfo): The vendor data.
        db (Session): The database session.
    
    Returns:
        VendorResponse: The created vendor's data.
    
    Raises:
        HTTPException: If the user ID is invalid.
    """
    # Create a new vendor object
    new_vendor = Vendor(
        can_ship=vendor.can_ship,
        description=vendor.description,
        status=vendor.status,
        rating=vendor.rating,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new vendor to the database
    db.add(new_vendor)
    db.commit()
    db.refresh(new_vendor)
    
    # Return the vendor's data in the VendorResponse format
    return new_vendor

@router.get("/{vendor_id}", response_model=VendorResponse)
def get_vendor(vendor_id: int, db: Session = Depends(get_db)):
    """
    Get a vendor by ID.
    
    Args:
        vendor_id (int): The ID of the vendor.
        db (Session): The database session.
    
    Returns:
        VendorResponse: The vendor's data.
    
    Raises:
        HTTPException: If the vendor is not found.
    """
    vendor = db.query(Vendor).filter(Vendor.id == vendor_id).first()
    if not vendor:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Vendor not found."
        )
    return vendor

@router.get("/", response_model=list[VendorResponse])
def get_all_vendors(db: Session = Depends(get_db)):
    """
    Get all vendors.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[VendorResponse]: A list of all vendors.
    """
    vendors = db.query(Vendor).all()
    return vendors

@router.put("/{vendor_id}", response_model=VendorResponse)
def update_vendor(vendor_id: int, vendor: VendorInfo, db: Session = Depends(get_db)):
    """
    Update a vendor by ID.
    
    Args:
        vendor_id (int): The ID of the vendor.
        vendor (VendorInfo): The updated vendor data.
        db (Session): The database session.
    
    Returns:
        VendorResponse: The updated vendor's data.
    
    Raises:
        HTTPException: If the vendor is not found.
    """
    # Find the vendor to update
    vendor_to_update = db.query(Vendor).filter(Vendor.id == vendor_id).first()
    if not vendor_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Vendor not found."
        )
    
    # Update the vendor's data
    vendor_to_update.can_ship = vendor.can_ship
    vendor_to_update.description = vendor.description
    vendor_to_update.status = vendor.status
    vendor_to_update.rating = vendor.rating
    vendor_to_update.updated_at = datetime.utcnow()
    
    # Commit the changes to the database
    db.commit()
    db.refresh(vendor_to_update)
    
    # Return the updated vendor's data
    return vendor_to_update

@router.delete("/{vendor_id}")
def delete_vendor(vendor_id: int, db: Session = Depends(get_db)):
    """
    Delete a vendor by ID.
    
    Args:
        vendor_id (int): The ID of the vendor.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the vendor is not found.
    """
    # Find the vendor to delete
    vendor_to_delete = db.query(Vendor).filter(Vendor.id == vendor_id).first()
    if not vendor_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Vendor not found."
        )
    
    # Delete the vendor from the database
    db.delete(vendor_to_delete)
    db.commit()
    
    return {"message": "Vendor deleted successfully."}
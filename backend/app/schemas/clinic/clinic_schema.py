from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

# Base Schema for Clinics
class ClinicBase(BaseModel):
    clinic_name: str
    specialization: str
    contact_email: EmailStr
    contact_phone: str
    website_url: Optional[str] = None
    status: str
    location_id: int

class ClinicCreate(ClinicBase):
    user_id: int  # User ID of the clinic owner

class ClinicUpdate(BaseModel):
    clinic_name: Optional[str] = None
    specialization: Optional[str] = None
    contact_email: Optional[EmailStr] = None
    contact_phone: Optional[str] = None
    website_url: Optional[str] = None
    status: Optional[str] = None

class ClinicResponse(ClinicBase):
    clinic_id: int
    created_at: datetime
    updated_at: datetime

    class Config:
        orm_mode = True

# Branch Schema
class ClinicBranchBase(BaseModel):
    branch_name: str
    location_id: int
    address: str
    phone_number: Optional[str]
    email: Optional[str]

class ClinicBranchCreate(ClinicBranchBase):
    clinic_id: int

class ClinicBranchResponse(ClinicBranchBase):
    branch_id: int

    class Config:
        orm_mode = True

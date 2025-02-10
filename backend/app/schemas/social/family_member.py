from pydantic import BaseModel, Field, EmailStr
from typing import Optional
from datetime import datetime, date
from enum import Enum
from app.schemas.enums_universal import Gender, Relationship

class FamilyMemberInfo(BaseModel):
    member_id: int  # Unique ID for the family member
    family_id: int  # Links to the family group
    full_name: str  # Name of the family member
    date_of_birth: date  # Birthdate for age-specific services
    gender: Gender  # Gender of the family member
    relationship: Relationship  # Relation to the primary user
    email: Optional[EmailStr] = None  # Optional email
    created_at: datetime = Field(default_factory=datetime.now)  # When the member was added
    updated_at: datetime = Field(default_factory=datetime.now)  # Last update timestamp

from pydantic import BaseModel, EmailStr, Field
from datetime import datetime, date
from typing import Optional, List, Dict
from enum import Enum, str
from decimal import Decimal


class SkillLevel(str, Enum):
    BEGINNER = "Beginner"
    INTERMEDIATE = "Intermediate"
    ADVANCED = "Advanced"
    PROFESSIONAL = "Professional"


class EventInformation(BaseModel):
    title: str
    description: str
    maximum_capacity: int = Field(gt=0)
    price: Decimal = Field(ge=0)
    age_range: str
    skill_level: SkillLevel
    location: str
    start_date: date
    end_date: date
    registration_deadline: datetime


class EventCreate(EventInformation):
    organizer_id: int
    event_type_id: int
    minimum_participants: Optional[int] = Field(default=None, gt=0)
    photo_url: Optional[str] = None
    venue_details: Optional[str] = None
    google_maps_url: str = Field(
        regex=r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(:\d+)?(\/[\w\-\.\/]*)*(\?[\w\-\.\=\&]*)?(\#[\w\-]*)?$",
        description="URL must be in a valid format (e.g., https://example.com)."
    )
    contact_email: Optional[EmailStr] = None
    contact_phone: Optional[str] = None


class EventResponse(BaseModel):
    event_id: int
    title: str
    description: str
    maximum_capacity: int
    current_registration_count: int = Field(ge=0)
    price: Decimal
    age_range: str
    skill_level: SkillLevel
    location: str
    start_date: date
    end_date: date
    person_performing : str
    registration_deadline: datetime
    status: str
    organizer_id: int
    event_type_id: int
    photo_url: Optional[str] = None
    venue_details: Optional[str] = None
    google_maps_url: str = Field(
        regex=r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(:\d+)?(\/[\w\-\.\/]*)*(\?[\w\-\.\=\&]*)?(\#[\w\-]*)?$",
        description="URL must be in a valid format (e.g., https://example.com)."
    )
    contact_email: Optional[EmailStr] = None
    contact_phone: Optional[str] = None
    created_at: datetime
    updated_at: datetime
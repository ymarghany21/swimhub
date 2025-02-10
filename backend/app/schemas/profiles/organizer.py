from pydantic import BaseModel
from typing import Optional
from app.schemas.profiles.user import UserInfo, speciality
from datetime import date, datetime
from enum import Enum


class organizerInfo(BaseModel):
    id : int
    organization_name : Optional[str]

class OrganizerResponse(BaseModel):
    id: int
    organization_name: Optional[str] = None

    class Config:
        from_attributes = True  # Enable ORM mode for SQLAlchemy models
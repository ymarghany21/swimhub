from pydantic import BaseModel
from typing import Optional
from datetime import datetime
from app.schemas.enums_universal import skillLevel

class SwimmerInfo(BaseModel):
    skill_level: skillLevel  
    goals: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    age_group: Optional[str] = None

class SwimmerResponse(BaseModel):
    id: int
    skill_level: str
    goals: Optional[str] = None
    created_at: datetime
    updated_at: datetime
    age_group: Optional[str] = None

    class Config:
        from_attributes = True  # Enable ORM mode for SQLAlchemy models
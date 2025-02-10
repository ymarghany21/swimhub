from pydantic import BaseModel, Field
from typing import Optional
from app.schemas.enums_universal import speciality

class AcademyInfo(BaseModel):
    specialty: speciality  
    coach_count: int
    business_license_url:str = Field(
        regex=r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(:\d+)?(\/[\w\-\.\/]*)*(\?[\w\-\.\=\&]*)?(\#[\w\-]*)?$",
        description="URL must be in a valid format (e.g., https://example.com)."
    )
    tax_number: Optional[str] = None
    contact_email: Optional[str] = None
    website_url: Optional[str] = None
    contact_phone_number: Optional[str] = None


class AcademyResponse(BaseModel):
    id: int
    specialty: str
    coach_count: int
    business_license_url: str
    tax_number: Optional[str] = None
    contact_email: Optional[str] = None
    website_url: Optional[str] = None
    contact_phone_number: Optional[str] = None

    class Config:
        from_attributes = True  # Enable ORM mode for SQLAlchemy models
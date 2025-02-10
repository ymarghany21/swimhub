from pydantic import BaseModel, EmailStr, field_validator, Field
from typing import Optional
from datetime import date
from enum import Enum, str
import re


class UserRole(str, Enum):
    SWIMMER = "swimmer or parent"
    COACH = "coach"
    ACADEMY = "academy"
    EVENT_ORGANIZER = "event_organizer"
    SUPPORT_AGENT = "support agent"
    ADMIN = "admin"
    PHOTOGRAPHER = "photographer"


class UserRegister(BaseModel):
    name: str
    email: EmailStr
    password: str = Field(
        min_length=8,
        regex=r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
        description="Password must be at least 8 characters long and include letters, numbers, and special characters."
    )
    confirm_password: str  # Confirm password field
    role: UserRole
    preferred_language: str = "en"
    gender: Optional[str] = None
    date_of_birth: Optional[date] = None
    phone_number: Optional[str] = None
    user_name: str

    @field_validator('confirm_password')
    def passwords_match(cls, v, values):
        if 'password' in values.data and v != values.data['password']:
            raise ValueError('Passwords do not match')
        return v    


class RegisterResponse(BaseModel):
    user_id: int
    email: str
    name: str
    role: UserRole
    user_name: str
    message: str = "Registration successful"
from pydantic import BaseModel, EmailStr, Field, field_validator
from datetime import datetime
from enum import Enum
from typing import Optional
import re
from app.schemas.enums_universal import Role, AccountStatus

class UserInfo(BaseModel):
    id: int
    name: str
    email: EmailStr
    phone_number: Optional[str] = None
    role: Role
    profile_photo_url: Optional[str] = None
    account_status: AccountStatus = AccountStatus.ACTIVE
    main_location: Optional[str] = None
    created_at: datetime
    updated_at: datetime



class userRegister(BaseModel):
    name: str
    email: EmailStr
    password: str = Field(
        min_length=8,
        regex=r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
        description="Password must be at least 8 characters long and include letters, numbers, and special characters."
    )
    confirm_password: str  # Confirm password field
    role: Role
    phone_number: Optional[str] = None
    profile_photo_url: Optional[str] = None
    main_location: Optional[str] = None

    @field_validator('confirm_password')
    def passwords_match(cls, v, values):
        if 'password' in values and v != values['password']:
            raise ValueError('Passwords do not match')
        return v


class userLogin(BaseModel):
    email : EmailStr
    password : str


class UserResponse(BaseModel):
    id: int
    name: str
    email: EmailStr
    phone_number: Optional[str] = None
    role: Role
    profile_photo_url: Optional[str] = None
    account_status: AccountStatus
    main_location: Optional[str] = None
    created_at: datetime
    updated_at: datetime
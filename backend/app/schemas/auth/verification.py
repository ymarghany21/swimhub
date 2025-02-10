from pydantic import BaseModel, EmailStr, Field, field_validator
from typing import Optional
from datetime import datetime
from enum import Enum, str


class VerificationType(str, Enum):
    EMAIL = "email"
    PHONE = "phone"


class VerificationStatus(str, Enum):
    PENDING = "pending"
    VERIFIED = "verified"
    FAILED = "failed"
    EXPIRED = "expired"


class EmailVerificationRequest(BaseModel):
    email: EmailStr


class EmailVerification(BaseModel):
    email: EmailStr
    token: str    # Token received in email



class PhoneVerification(BaseModel):
      phone_number: str = Field(
        min_length=11,  # Egyptian phone numbers are exactly 11 digits
        max_length=11,  # No more, no less
        regex=r"^01[0125][0-9]{8}$",  # Regex for Egyptian phone numbers
        description="Phone number must be in Egyptian format (e.g., 01012345678)."
    )
      code : str = Field(
        min_length=6,
        max_length=6,
        regex=r"^\d{6}$",  # Validates a 6-digit code
        description="Verification code must be a 6-digit number."
    )

class VerificationResponse(BaseModel):
    type: VerificationType
    status: VerificationStatus
    verified_at: Optional[datetime] = None
    message: str


class UserVerificationStatus(BaseModel):
    user_id: int
    email_verified: bool
    phone_verified: bool
    email_verified_at: Optional[datetime] = None
    phone_verified_at: Optional[datetime] = None


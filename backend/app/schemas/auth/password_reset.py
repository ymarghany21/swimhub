from pydantic import BaseModel, EmailStr, Field
from typing import Optional


class PasswordResetRequest(BaseModel):
    email: EmailStr


class PasswordResetConfirm(BaseModel):
    token: str
    password: str = Field(min_length=8)
    confirm_password: str


class PasswordChange(BaseModel):
    current_password: str
    new_password: str = Field(min_length=8)
    confirm_password: str


class PasswordResponse(BaseModel):
    message: str
    success: bool
from pydantic import BaseModel, Field, EmailStr, constr  # For schema definitions and validations
from enum import Enum  # For enums like service types or statuses
from typing import Optional, List  # For optional fields and lists
from datetime import datetime  # For timestamps
from app.schemas.enums_universal import DeliveryStatus, Priority, Purpose

class NotificationInfo(BaseModel):
    user_id : int
    type : Purpose
    title : str
    body : str
    delivery_time : Optional[datetime] = None 
    status: DeliveryStatus
    priority : Priority

class NotificationResponse(BaseModel):
    notification_id: int
    success : bool
    message : str





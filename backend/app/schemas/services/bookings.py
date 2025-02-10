from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime, date
from enum import Enum
from app.schemas.enums_universal import speciality, PaymentMethod, TransactionStatus, sessionStatus




class bookingInfo(BaseModel):
    booking_id : int
    listing_id : int
    buyer_id : int  # the id of the person who paid in some cases it might be parents who paid for their kids 
    memeber_id : int   # this is optional for kids who had their parents get them a booking
    provider_id : int   # coach id
    provider_type : speciality
    location_id : int
    location_url : str = Field(
        regex=r"^(https?:\/\/)?([\w\-]+\.)+[\w\-]+(:\d+)?(\/[\w\-\.\/]*)*(\?[\w\-\.\=\&]*)?(\#[\w\-]*)?$",
        description="URL must be in a valid format (e.g., https://example.com)."
    )

    session_type : speciality
    price : float
    payment_method : PaymentMethod
    payment_status : TransactionStatus
    session_status : sessionStatus
    created_at: datetime = datetime.now()  
    updated_at: datetime = datetime.now()  
    
from pydantic import EmailStr, BaseModel, Field
from datetime import datetime, date
from typing import Optional, List
from app.schemas.enums_universal import DeliveryStatus, Priority, Purpose
from pydantic import HttpUrl

class EmailInfo(BaseModel):
    user_id : int
    email: EmailStr
    type: Purpose
    subject : str
    body : str
    attachments: Optional[List[HttpUrl]] = Field(
        default_factory=list,
        description="List of URLs pointing to files stored in cloud storage."
    )
    delivery_time : Optional[datetime] = None
    status: DeliveryStatus = DeliveryStatus.PENDING


class EmailResponse(BaseModel):
    message: str
    success: bool
    email_id: Optional[int] = None
from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime
from enum import Enum

class Status(str, Enum):
    OPEN = "open"
    IN_PROGRESS = "in_progress"
    CLOSED = "closed"

class TicketInfo(BaseModel):
    ticket_id: int  
    agent_id: Optional[int] = None  
    user_id: int  
    title: str = Field(..., max_length=100) 
    description: str = Field(..., max_length=1000)  
    status: Status = Status.OPEN  
    created_at: datetime = Field(default_factory=datetime.now)  
    updated_at: datetime = Field(default_factory=datetime.now)  

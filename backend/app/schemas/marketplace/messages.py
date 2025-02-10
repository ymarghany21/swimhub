from pydantic import Field, BaseModel
from typing import list, Optional
from datetime import datetime, date
from enum import Enum

class Status(str, Enum):
    SENT= "sent"
    SEEN = "seen"
    FAILED = "failed"
    DELETED = "deleted"


class MessageInfo(BaseModel): 
    message_id: int
    listing_id: int
    sender_id : int
    receiver_id : int
    message_content : str
    message_status = Status
    sent_at : datetime

    
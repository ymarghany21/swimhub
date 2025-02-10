from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum


class ChatType(str, Enum):
    MARKETPLACE = "marketplace"

class Message(BaseModel):
    message_id: int
    sender_id: int  # ID of the sender (user or coach)
    content: str  # Text content of the message
    sent_at: datetime = Field(default_factory=datetime.now)  # Timestamp when the message was sent

class IndividualChatInfo(BaseModel):
    chat_room_id: int  # Unique identifier for the chat room
    seller_id: int  # User participating in the chat
    buyer_id: Optional[int] = None  # Optional, for chats involving a coach
    session_id: Optional[int] = None  # Optional, if tied to a session
    chat_type: ChatType = ChatType.INDIVIDUAL  # Type of chat
    messages: Optional[List[Message]] = None  # List of messages
    created_at: datetime = Field(default_factory=datetime.now)  # When the chat room was created

from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from enum import Enum

class ParticipantRole(str, Enum):
    PARENT = "parent"
    SWIMMER = "swimmer"
    COACH = "coach"

class Message(BaseModel):
    message_id: int
    sender_id: int  # ID of the sender (user)
    content: str  # Message content
    sent_at: datetime = Field(default_factory=datetime.now)  # Timestamp of the message

class Participant(BaseModel):
    user_id: int  # ID of the participant
    role: ParticipantRole  # Role in the session (parent, swimmer, coach)

class SessionGroupChatInfo(BaseModel):
    chat_room_id: int  # Unique identifier for the chat room
    session_id: int  # Links the chat to the session
    participants: List[Participant]  # List of participants in the session
    messages: Optional[List[Message]] = None  # List of messages
    created_at: datetime = Field(default_factory=datetime.now)  # Timestamp for when the chat was created

from pydantic import BaseModel
from typing import Optional, Literal
from datetime import datetime


class CommunityJoinRequestCreate(BaseModel):
    community_id: int
    message: Optional[str] = None


class CommunityJoinRequestResponse(BaseModel):
    request_id: int
    community_id: int
    user_id: int
    status: Literal['pending', 'approved', 'rejected']
    message: Optional[str]
    created_at: datetime
    updated_at: datetime
from pydantic import BaseModel, Field
from datetime import datetime
from enum import Enum, str
from typing import Optional, List



class communityBase(BaseModel):
    name: str
    description : str



class communityCreate(communityBase):
    pass

class CommunityResponse(communityBase):
    community_id: int
    community_link: str
    created_at: datetime
    updated_at: datetime
    invite_enabled: bool


from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime
from app.schemas.social.family_member import FamilyMemberInfo  


class FamilyGroupInfo(BaseModel):
    family_id: int  # Unique ID for the family group
    primary_user_id: int  # The main user managing the group
    family_name: Optional[str] = "My Family"  # Default name for the family group
    created_at: datetime = Field(default_factory=datetime.now)  # Creation timestamp
    members: Optional[List[FamilyMemberInfo]] = None  # Optional list of family members

from app.schemas.profiles.user import UserInfo, BaseModel
from datetime import datetime

class agentInfo(UserInfo):
    department : str
    created_at: datetime
    updated_at: datetime

class AgentResponse(BaseModel):
    id: int
    department: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True  # Enable ORM mode for SQLAlchemy models
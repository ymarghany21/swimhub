from pydantic import BaseModel, Field
from datetime import datetime
from enum import Enum, str
from typing import Optional, List


class locationInfo(BaseModel):
    id: int
    governorate : str
    city : str
    location_url : str
    created_at: datetime = Field(default_factory=datetime.now)  
    updated_at: datetime = Field(default_factory=datetime.now)  



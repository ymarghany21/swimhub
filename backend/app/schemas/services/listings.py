from pydantic import BaseModel, EmailStr
from typing import Optional, Dict, List
from datetime import datetime, date
from enum import Enum
from app.schemas.enums_universal import speciality, Status, skillLevel
from app.schemas.location.enums import Governorates


class listingInfo(BaseModel):
    listing_id : int
    title : str
    listing_type : speciality
    description : str
    status : Status
    governorate : Governorates
    city : str
    location_id : int
    schedule_type : type
    sessions_per_week : int
    custom_schedule: Optional[Dict[str, List[str]]] = None  
    indvidual_price : float 
    indvidual_duration : float
    group_price : float
    group_duration : float
    min_students : int
    max_students : int
    current_students : int
    age_group : str
    skill_level : skillLevel
    created_at: datetime = datetime.now()  
    updated_at: datetime = datetime.now()






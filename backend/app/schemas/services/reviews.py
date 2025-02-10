from pydantic import BaseModel, EmailStr, confloat, Field
from typing import Optional, Dict, List
from datetime import datetime, date
from enum import Enum



class reviewInfo(BaseModel):
    review_id : int
    seller_id : int
    buyer_id : int
    rating: str = Field(
        regex=r"^(?:5(?:\.0+)?|[0-4](?:\.[0-9]+)?)$",
        description="Rating must be a number between 0 and 5, inclusive. Decimals are allowed."
    )
    average_rating : float
    feedback : Optional[str] = None
    created_at: datetime = Field(default_factory=datetime.now)  
    updated_at: datetime = Field(default_factory=datetime.now) 


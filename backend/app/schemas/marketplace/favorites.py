from pydantic import EmailStr, Field, BaseModel
from typing import Optional, List
from enum import Enum
from datetime import date, datetime

class FavoriteInfo(BaseModel):
    user_id : int
    listing_id : int
    added_date : datetime

class FavoriteResponse(BaseModel):
    user_id: int
    listing_id: int
    title: str
    price: float
    image_url: Optional[str] = None
    added_date: datetime



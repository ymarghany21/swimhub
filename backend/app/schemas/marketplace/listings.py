from pydantic import EmailStr, Field, BaseModel
from typing import Optional, List
from datetime import date, datetime
from decimal import Decimal
from app.schemas.marketplace.item_info import ItemCondition, ItemAgeGroup, ItemCategory, Itemcompitability, ItemGender, ItemSize, ItemSport, ItemType, Brand, NumericSizes


class ListingInfo(BaseModel):
    listing_id : int
    user_id : int
    title : str
    price : Decimal= Field(..., gt=0)  
    description: str
    item_condition = ItemCondition
    item_age_group = ItemAgeGroup
    item_category = ItemCategory
    item_compitability = Itemcompitability
    item_gender = ItemGender
    item_size = ItemSize
    item_sport = ItemSport
    item_type = ItemSport
    location_id : int
    created_at : datetime
    updated_at : datetime
    brand = Brand
    size = NumericSizes
    shipping_available : bool
    images = str
    location : Optional[str] = None



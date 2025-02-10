from datetime import datetime
from typing import Optional
from decimal import Decimal
from enum import Enum
from pydantic import BaseModel
from app.schemas.enums_universal import CommissionPersonell, CommissionTypes


class CommissionInfo(BaseModel):
    commission_id: int  
    person_type: CommissionPersonell  # Who is paying the commission
    commission_type: CommissionTypes  # Type of commission (e.g., booking or purchase)
    rate: Decimal  # Percentage rate for the commission (e.g., 0.15 for 15%)
    rate_type: str = "percentage"  # Defaults to "percentage" since all are percentage-based
    description: Optional[str] = None  # Optional details or notes
    created_at: datetime = datetime.now()  # Timestamp for when the commission was created
    updated_at: Optional[datetime] = None  # Timestamp for the last update

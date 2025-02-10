from pydantic import BaseModel, Field
from enum import Enum
from datetime import datetime, date
from typing import Optional
from decimal import Decimal
from app.schemas.enums_universal import RefundTypes



class RefundInfo(BaseModel):
    refund_id: int  # Unique identifier for the refund
    transaction_id: int  # Links to the transaction being refunded
    refund_type: RefundTypes  # Type of refund
    refund_amount: Decimal  # Amount to be refunded
    reason: Optional[str] = None  # Optional explanation for the refund
    created_at: datetime = datetime.now()  # Timestamp when the refund was created
    status: str = "pending"  # Refund status: 'pending', 'completed', or 'failed'


class RefundStatus(str, Enum):
    PENDING = "pending"
    COMPLETED = "completed"
    FAILED = "failed"

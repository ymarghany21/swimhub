from typing import Optional, List
from decimal import Decimal
from enum import Enum
from pydantic import BaseModel
from datetime import datetime
from app.schemas.enums_universal import TransactionStatus, TransactionTypes, PaymentMethod

class Transaction(BaseModel):
    transaction_id: int  # Unique identifier for the transaction
    transaction_type: TransactionTypes  # Type of transaction (commission, purchase, etc.)
    user_id: int  # ID of the user initiating the transaction
    recipient_id: Optional[int] = None  # ID of the recipient (if applicable, e.g., for commissions)
    amount: Decimal  # Transaction amount
    payment_method: PaymentMethod  # Method of payment
    status: TransactionStatus = TransactionStatus.PENDING  # Default to 'pending'
    description: Optional[str] = None  # Optional description or notes for the transaction
    created_at: datetime = datetime.now()  # Timestamp for when the transaction was created
    updated_at: Optional[datetime] = None  # Timestamp for when the transaction was last updated

class WalletTransaction(BaseModel):
    wallet_transaction_id: int  # Unique ID for the wallet transaction
    user_id: int  # Links to the user
    transaction_type: str  # 'topup' or 'withdrawal'
    amount: Decimal  # Amount credited or debited
    status: TransactionStatus = TransactionStatus.PENDING  # Default to 'pending'
    created_at: datetime = datetime.now()  # Timestamp for the transaction
    updated_at: Optional[datetime] = None  # Last update timestamp

class PayoutInfo(BaseModel):
    payout_id: int  # Unique ID for the payout
    recipient_id: int  # User receiving the payout
    amount: Decimal  # Payout amount
    payout_method: PaymentMethod  # Method of payout
    status: TransactionStatus = TransactionStatus.PENDING  # Default to 'pending'
    created_at: datetime = datetime.now()  # Timestamp for the payout
    updated_at: Optional[datetime] = None  # Timestamp for updates

class PromoCodeTransaction(BaseModel):
    promo_code_id: int  # ID of the promo code
    transaction_id: int  # Links to the transaction
    discount_amount: Decimal  # Discount applied
    user_id: int  # User who applied the promo code
    applied_at: datetime = datetime.now()  # Timestamp of promo code application

class TransactionLog(BaseModel):
    log_id: int  
    transaction_id: int  
    action: str  
    performed_by: int  
    timestamp: datetime = datetime.now()  
    details: Optional[str] = None  

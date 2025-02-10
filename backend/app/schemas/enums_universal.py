from pydantic import BaseModel, EmailStr, field_validator, Field
from typing import Optional
from datetime import date
from enum import Enum, str
import re

## verification enums

class VerificationType(str, Enum):
    EMAIL = "email"
    PHONE = "phone"


class VerificationStatus(str, Enum):
    PENDING = "pending"
    VERIFIED = "verified"
    FAILED = "failed"
    EXPIRED = "expired"


## user creation enums


class Role(str, Enum):
    SWIMMER_PARENT = "swimmer or parent"
    COACH = "coach"
    ACADEMY = "academy"
    EVENT_ORGANIZER = "event_organizer"
    SUPPORT_AGENT = "support agent"
    ADMIN = "admin"
    PHOTOGRAPHER = "photographer"
    VENDOR = "vendor"

class AccountStatus(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    SUSPENDED = "suspended"
    BANNED = "banned"

class gender(str, Enum):
    MALE = "male"
    FEMALE = "female"

class speciality(str, Enum):
    SWIMMING = "swimming"
    FITNESS = "fitness"

class skillLevel(str, Enum):
    BEGINNER = "beginner"
    INTERMEDIATE = "intermediate"
    ADVANCED = "advanced"


##event enums

class AttendanceStatus(str, Enum):
    ATTENDED = "attended"
    NO_SHOW = "no-show"
    CANCELLED = "cancelled"

class SkillLevel(str, Enum):
    BEGINNER = "Beginner"
    INTERMEDIATE = "Intermediate"
    ADVANCED = "Advanced"
    PROFESSIONAL = "Professional"


## items info enums


class ItemCategory(str, Enum):
    CLOTHING = "clothing"
    ACCESSORIES = "accessories"
    EQUIPMENT = "equipment"

class ItemSize(str, Enum):
    SMALL = "small"
    MEDIUM = "medium"
    LARGE = "large"
    XL = "xl"

class ItemAgeGroup(str, Enum):
    ADULT = "adult"
    JUNIOR = "junior"

class ItemCondition(str, Enum):
    USED = "used"
    NEW = "new"

class ItemSport(str, Enum):
    FITNESS = "fitness"
    SWIMMING = "swimming" 

class ItemGender(str , Enum):
    MEN = "men"
    WOMEN = "women"

class Itemcompitability(str, Enum):
    RACING = "racing"
    TRAINING = "training"

class ItemType(str, Enum):
    SWIM_WEAR = "swim_wear"
    GOOGLES = "goggles"
    BAGS = "bags"
    CAPS = "caps"
    EQUIPMENT = "equipment"
    
class Brand(str, Enum):
    ARENA = "arena"
    SPEEDO = "speedo"
    MADWAVE = "madwave"
    A3 = "a3"
    FUNKITA = "funkita"
    FUNKY_TRUNKS = "funky_trunks"
    ZOYA = "zoya"
    ONE_SWIM_POWER = "one_swim_power"
    FINIS = "finis"
    YINGFA = "yingfa"
    TEMPO = "tempo"
    MEGA_DOLPHIN = "mega_dolphin"
    TYR = "tyr"
    


class NumericSizes(str, Enum):
    SIZE_20 = "20"
    SIZE_21 = "21"
    SIZE_22 = "22"
    SIZE_23 = "23"
    SIZE_24 = "24"
    SIZE_25 = "25"
    SIZE_26 = "26"
    SIZE_27 = "27"
    SIZE_28 = "28"
    SIZE_29 = "29"
    SIZE_30 = "30"
    SIZE_31 = "31"
    SIZE_32 = "32"
    SIZE_33 = "33"
    SIZE_34 = "34"
    SIZE_35 = "35"
    SIZE_36 = "36"
    SIZE_37 = "37"
    SIZE_38 = "38"
    SIZE_39 = "39"
    SIZE_40 = "40"

## messages status enums

class messageStatus(str, Enum):
    SENT= "sent"
    SEEN = "seen"
    FAILED = "failed"
    DELETED = "deleted"



## notifications enums


class Purpose(str, Enum):
    INFORMATIONAL = "informational"
    PROMOTIONAL = "promotional"
    REMINDER = "reminder"

class DeliveryStatus(str, Enum):
    DELIVERED = "delivered"
    PENDING = "pending"
    FAILED = "failed"
    SENT = "sent"

class Priority(str, Enum):
    HIGH = "high"
    MEDIUM = "medium"
    LOW = "low"


class NotificationPlatforms(str, Enum):
    IN_APP = "in_app"
    PUSH = "push"
    EMAIL = "email"
    SMS = "sms"




## commission enums

class CommissionPersonell(str, Enum):
    COACH = "coach"
    CUSTOMER = "customer"  
    EVENT_ORGANIZER = "event_organizer"
    ACADEMY = "academy"
    VENDOR = "vendor"

class CommissionTypes(str, Enum):
    ON_BOOKING = "on_booking"  
    ON_PURCHASE = "on_purchase"


## refund types enums

class RefundTypes(str, Enum):
    BOOKING_CANCELLATION = "booking cancellation"  # Refund due to booking being canceled
    VENDOR_PRODUCT_RETURN = "vendor product return"  # Refund due to returning a product to a vendor
    SERVICE_ISSUE = "service issue"  # Refund due to dissatisfaction with service quality
    SYSTEM_ERROR = "system error"  # Refund due to technical or payment system issues


## transaction enums

class TransactionTypes(str, Enum):
    COMMISSION = 'commission'
    PURCHASE = 'purchase'
    SESSION_BOOKING = "session_booking"
    EVENT_BOOKING = "event_booking"
    REFUND = "refund"  # This can reference refunds in the refund file
    SUBSCRIPTION = "subscription"
    WALLET_WITHDRAWAL = "wallet_withdrawal"
    WALLET_TOPUP = "wallet_topup"
    CANCELLATION_FEE = "cancellation_fee"

class TransactionStatus(str, Enum):
    PENDING = "pending"
    COMPLETED = "completed"
    FAILED = "failed"
    REFUNDED = "refunded"

class PaymentMethod(str, Enum):
    CREDIT_CARD = "credit_card"
    FAWRY = "fawry"
    WALLET = "wallet"
    BANK_TRANSFER = "bank_transfer"
    INSTAPAY = "instapay"
    CARRIER_CASH = "carrier_cash" #like vodafone, etisalat, orange cash


## session status

class sessionStatus(str, Enum):
    UPCOMING = "upcoming"
    COMPLETED = "completed"
    CANCELLED = "cancelled"


## session type

class type(str, Enum):   ##this is the schedule type
    ONE_TIME = "one_time"
    WEEKLY = "weekly"
    MONTHLY = "monthly"


## family info stuff enums

class Gender(str, Enum):
    MALE = "male"
    FEMALE = "female"
    OTHER = "other"

class Relationship(str, Enum):
    SON = "son"
    DAUGHTER = "daughter"
    OTHER = "other"
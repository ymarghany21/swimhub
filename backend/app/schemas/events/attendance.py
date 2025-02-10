from pydantic import BaseModel, Field
from datetime import datetime
from enum import Enum, str
from typing import Optional, List


class AttendanceStatus(str, Enum):
    ATTENDED = "attended"
    NO_SHOW = "no-show"
    CANCELLED = "cancelled"


class AttendanceBase(BaseModel):
    attendance_id : int
    event_id: int
    attendee_id: int
    status: AttendanceStatus = AttendanceStatus.ATTENDED


class AttendanceCreate(AttendanceBase):
    pass


class AttendanceUpdate(BaseModel):
    status: AttendanceStatus


class AttendanceResponse(AttendanceBase):
    attendance_id: int
    created_at: datetime
    updated_at: datetime


class BulkAttendanceCreate(BaseModel):
    event_id: int
    attendee_ids: List[int]
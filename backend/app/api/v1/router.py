from fastapi import APIRouter
from . import login, register, forgot_password, reset_password, verify_email

auth_router = APIRouter()
auth_router.include_router(login.router, prefix="/login", tags=["Auth"])
auth_router.include_router(register.router, prefix="/register", tags=["Auth"])
auth_router.include_router(forgot_password.router, prefix="/forgot-password", tags=["Auth"])
auth_router.include_router(reset_password.router, prefix="/reset-password", tags=["Auth"])
auth_router.include_router(verify_email.router, prefix="/verify-email", tags=["Auth"])

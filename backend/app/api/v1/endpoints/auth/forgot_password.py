from fastapi import APIRouter, HTTPException
from app.db.database import db_session
from app.models import User
from app.api.v1.endpoints.auth.utils import generate_verification_token, send_email

router = APIRouter()

@router.post("/auth/forgot-password")
def forgot_password(email: str):
    user = db_session.query(User).filter(User.email == email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    reset_token = generate_verification_token(user.id)
    reset_link = f"https://yourapp.com/auth/reset-password?token={reset_token}"
    send_email(email, "Reset Your Password", f"Click here to reset: {reset_link}")

    return {"message": "Password reset link sent to your email."}

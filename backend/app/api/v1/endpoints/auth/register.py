from fastapi import APIRouter, HTTPException
from app.db.database import db_session
from app.models import User
from app.api.v1.endpoints.auth.utils import hash_password, generate_verification_token, send_email

router = APIRouter()

@router.post("/auth/register")
def register(email: str, password: str):
    if db_session.query(User).filter(User.email == email).first():
        raise HTTPException(status_code=400, detail="Email already registered")

    hashed_password = hash_password(password)
    new_user = User(email=email, password=hashed_password, is_verified=False)
    db_session.add(new_user)
    db_session.commit()

    token = generate_verification_token(new_user.id)
    verification_link = f"https://yourapp.com/auth/verify-email?token={token}"
    send_email(email, "Verify Your Email", f"Click here to verify: {verification_link}")

    return {"message": "User registered. Check your email to verify your account."}

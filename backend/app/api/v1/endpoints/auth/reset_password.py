from fastapi import APIRouter, HTTPException
from app.db.database import db_session
from app.models import User
from app.api.v1.endpoints.auth.utils import verify_token, hash_password

router = APIRouter()

@router.post("/auth/reset-password")
def reset_password(token: str, new_password: str):
    user_id = verify_token(token)
    if not user_id:
        raise HTTPException(status_code=400, detail="Invalid or expired token")

    user = db_session.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.password = hash_password(new_password)
    db_session.commit()

    return {"message": "Password reset successful!"}

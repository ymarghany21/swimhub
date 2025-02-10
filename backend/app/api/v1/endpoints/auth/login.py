from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import OAuth2PasswordRequestForm
from app.db.database import db_session
from app.models import User
from app.api.v1.endpoints.auth.token import create_access_token
from app.api.v1.endpoints.auth.utils import verify_password

router = APIRouter()

@router.post("/auth/login")
def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = db_session.query(User).filter(User.email == form_data.username).first()

    if not user or not verify_password(form_data.password, user.password):
        raise HTTPException(status_code=401, detail="Invalid email or password")

    if not user.is_verified:
        raise HTTPException(status_code=403, detail="Email not verified")

    access_token = create_access_token({"sub": user.email, "user_id": user.id})
    return {"access_token": access_token, "token_type": "bearer"}

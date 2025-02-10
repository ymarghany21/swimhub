from app.db.database import SessionLocal
from app.models.models import User

def get_user_by_username(username: str):
    """Retrieve a user by their user_name."""
    db = SessionLocal()
    try:
        user = db.query(User).filter_by(user_name=username).first()
        return user
    finally:
        db.close()

if __name__ == "__main__":
    # Example usage
    user = get_user_by_username("jdoe123")
    if user:
        print(f"Found user: {user.name}, Email: {user.email}, ID: {user.user_id}")
    else:
        print("No user found with that user_name.")

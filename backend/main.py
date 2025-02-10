from fastapi import FastAPI

app = FastAPI(title="My Mobile App Backend", version="1.0.0")

@app.get("/")
def home():
    return {"message": "Welcome to the Mobile App Backend!"}




from fastapi import HTTPException

@app.post("/users")
def create_user(name: str, email: str):
    if not name or not email:
        raise HTTPException(status_code=400, detail="Name and email are required")

    # For now, just return the data (we're not saving it yet)
    new_user = {
        "id": 3,  # Hardcoded ID for now
        "name": name,
        "email": email
    }
    return new_user
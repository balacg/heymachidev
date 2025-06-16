# heymachi_backend/core/security.py

from passlib.context import CryptContext
from datetime import datetime, timedelta
from typing import Optional
import jwt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from pydantic import BaseModel
from database import get_db
from models.user import User

# Secrets & constants
SECRET_KEY = "supersecretkey"  # 🔐 Replace with env var for prod
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# OAuth2 setup
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/token")  # Fix the token URL here

# -------------------------------------------
# ✅ Pydantic model for session context
# -------------------------------------------
class UserSession(BaseModel):
    username: str
    email: str
    user_id: int
    business_id: str
    is_admin: bool

# -------------------------------------------
# ✅ Utility: Verify password
# -------------------------------------------
def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

# -------------------------------------------
# ✅ Utility: Hash password
# -------------------------------------------
def get_password_hash(password):
    return pwd_context.hash(password)

# -------------------------------------------
# ✅ Utility: Create JWT access token
# -------------------------------------------
def create_access_token(data: dict, expires_delta: Optional[timedelta] = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

# -------------------------------------------
# ✅ Utility: Get user from DB
# -------------------------------------------
def get_user(db: Session, username: str):
    return db.query(User).filter(User.username == username).first()

# -------------------------------------------
# ✅ Auth: Authenticate credentials
# -------------------------------------------
def authenticate_user(db: Session, username: str, password: str):
    user = get_user(db, username)
    if not user or not verify_password(password, user.hashed_password):
        return False
    return user

# -------------------------------------------
# ✅ Dependency: Current logged in user context
# -------------------------------------------
async def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception

        user = get_user(db, username)
        if user is None:
            raise credentials_exception

        return user
    except jwt.PyJWTError:
        raise credentials_exception

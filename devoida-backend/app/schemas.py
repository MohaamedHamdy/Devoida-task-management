from pydantic import BaseModel
from datetime import datetime
from typing import Optional

class User(BaseModel):
    username: str
    email : str
    password_hash : str
    profile_picture : str
    
    class Config:
        orm_mode = True



class UserOut(BaseModel):
    id: int
    username: str
    email: str
    profile_picture: str
    created_at: datetime

    class Config:
        orm_mode = True

class Login(BaseModel):
    username : str
    password : str
    
    class Config:
        orm_mode = True

class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    email: Optional[str] = None

class WorkSpace(BaseModel):
    name: str
    description: str
    class Config:
        orm_mode = True
    # created_by: int
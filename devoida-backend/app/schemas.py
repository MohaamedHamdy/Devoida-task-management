from pydantic import BaseModel
from datetime import datetime

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
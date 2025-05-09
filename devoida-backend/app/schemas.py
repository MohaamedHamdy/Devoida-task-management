from pydantic import BaseModel

class User(BaseModel):
    username: str
    email : str
    password_hash : str
    profile_picture : str
    
    class Config:
        orm_mode = True
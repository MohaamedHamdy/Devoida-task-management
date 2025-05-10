from pydantic import BaseModel
from datetime import datetime, date
from typing import Optional, List
from app.models import models

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

class UsersListResponse(BaseModel):
    Status: str
    data: List[UserOut]

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

class AddToWorkspace(BaseModel):
    workspace_id : int
    user_id : int
    class Config:
        orm_mode = True

class WorkSpaceOut(BaseModel):
    id: int
    name: str
    description: str
    created_by: Optional[int]

    class Config:
        orm_mode = True

class WorkSpaceListResponse(BaseModel):
    Status: str
    data: List[WorkSpaceOut]

class BoardCreate(BaseModel):
    name: str
    description: str
    workspace_id: int


class BoardUpdate(BaseModel):
    name: str


class BoardOut(BaseModel):
    id: int
    name: str
    workspace_id: int
    created_by: int
    created_at: datetime

    class Config:
        orm_mode = True


class BoardListResponse(BaseModel):
    Status: str
    data: List[BoardOut]

class TaskBase(BaseModel):
    title: str
    description: Optional[str]
    board_id: int
    due_date: Optional[date]
    status: Optional[models.StatusEnum] = models.StatusEnum.todo


class TaskCreate(TaskBase):
    pass


class TaskUpdate(BaseModel):
    title: Optional[str]
    description: Optional[str]
    due_date: Optional[date]
    status: Optional[models.StatusEnum]


class TaskOut(BaseModel):
    id: int
    title: str
    description: Optional[str]
    status: models.StatusEnum
    due_date: Optional[date]
    board_id: int
    created_by: int
    assigned_to: Optional[int] 
    created_at: datetime

    class Config:
        orm_mode = True
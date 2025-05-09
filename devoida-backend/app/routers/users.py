from fastapi import APIRouter, Depends, status
from .. import schemas, database, oauth2
from typing import List
from app.models import models
from ..hashing import Hash
from ..repository import users
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession

router = APIRouter(
    prefix="/user",
    tags=['User']
)


@router.post('/', status_code=status.HTTP_201_CREATED)
async def create_user(request: schemas.User, db:Session = Depends(database.get_db)):
    return await users.create_user(request, db)

@router.get('/', response_model=List[schemas.UserOut])
async def get_all(db: AsyncSession = Depends(database.get_db), current_user: schemas.User = Depends(oauth2.get_current_user)):
    return await users.get_all(db)

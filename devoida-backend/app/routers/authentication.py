from fastapi import APIRouter, Depends, status, HTTPException
from .. import schemas, database
from typing import List
from app.models import models
from ..hashing import Hash
from ..repository import users
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

router = APIRouter(
    tags=['Authentication']
)


@router.post('/login')
async def login(request: schemas.Login, db: AsyncSession = Depends(database.get_db)):
    stmt = select(models.User).where(models.User.email == request.username)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()

    if not user:
        raise HTTPException(status_code=404, detail="Invalid credentials")

    if not Hash.verify(user.password_hash, request.password):
        raise HTTPException(status_code=401, detail="Incorrect password")


    return user
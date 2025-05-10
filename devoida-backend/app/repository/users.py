from sqlalchemy.orm import Session
from ..models import models
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select, or_
from fastapi import Depends, Query
from .. import schemas, database
from ..hashing import Hash


async def get_all(db: AsyncSession):
    result = await db.execute(select(models.User))
    return result.scalars().all()

async def create_user(request: schemas.User, db:Session = Depends(database.get_db)):
    new_user = models.User(username = request.username, 
                           password_hash = Hash.bcrypt(request.password_hash), 
                           email = request.email, 
                           profile_picture = request.profile_picture)
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)
    return new_user

async def search_users(
    query: str = Query(..., min_length=1),
    db: AsyncSession = Depends(database.get_db)
):
    stmt = select(models.User).where(
        or_(
            models.User.username.ilike(f"%{query}%"),
            models.User.email.ilike(f"%{query}%")
        )
    )
    result = await db.execute(stmt)
    users = result.scalars().all()
    return users
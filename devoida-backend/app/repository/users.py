from sqlalchemy.orm import Session
from ..models import models
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from fastapi import Depends
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
from fastapi import APIRouter, Depends, HTTPException
from .. import schemas, database, token
from app.models import models
from ..hashing import Hash
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select
from fastapi.security import OAuth2PasswordRequestForm

router = APIRouter(
    tags=['Authentication']
)


@router.post('/login')
async def login(request:OAuth2PasswordRequestForm = Depends(), db: AsyncSession = Depends(database.get_db)):
    print(request)
    stmt = select(models.User).where(models.User.email == request.username)
    result = await db.execute(stmt)
    user = result.scalar_one_or_none()

    if not user:
        raise HTTPException(status_code=404, detail="Invalid credentials")

    if not Hash.verify(user.password_hash, request.password):
        raise HTTPException(status_code=401, detail="Incorrect password")


    access_token = token.create_access_token(data={"sub": user.email, "user_id": user.id})
    return {"access_token": access_token, "token_type": "bearer"}
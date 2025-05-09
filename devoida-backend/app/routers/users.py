from fastapi import APIRouter, Depends, status
from .. import schemas, database
from app.models import models
from ..hashing import Hash
from sqlalchemy.orm import Session

router = APIRouter(
    prefix="/user",
    tags=['User']
)


@router.post('/', status_code=status.HTTP_201_CREATED)
async def create_user(request: schemas.User, db:Session = Depends(database.get_db)):
    new_user = models.User(username = request.username, 
                           password_hash = Hash.bcrypt(request.password_hash), 
                           email = request.email, 
                           profile_picture = request.profile_picture)
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)
    return new_user

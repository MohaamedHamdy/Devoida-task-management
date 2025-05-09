from fastapi import FastAPI, Depends
from app.database import engine, Base
from app.models import models
from . import schemas
from sqlalchemy.orm import Session
app = FastAPI()
from . import database

@app.on_event("startup")
async def on_startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def root():
    return {"message": "Task Management API is up!"}

@app.post('/user')
async def create_user(request: schemas.User, db:Session = Depends(database.get_db)):
    new_user = models.User(username = request.username, 
                           password_hash = request.password_hash, 
                           email = request.email, 
                           profile_picture = request.profile_picture)
    db.add(new_user)
    await db.commit()
    await db.refresh(new_user)
    return new_user

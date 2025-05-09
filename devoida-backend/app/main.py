from fastapi import FastAPI
from app.database import engine, Base
from app.models import models  # Import user model

app = FastAPI()

@app.on_event("startup")
async def on_startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def root():
    return {"message": "Task Management API is up!"}

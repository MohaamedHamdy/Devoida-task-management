from fastapi import FastAPI
from app.database import engine, Base
from .routers import users, authentication

app = FastAPI()

@app.on_event("startup")
async def on_startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def root():
    return {"message": "Task Management API is up!"}

app.include_router(authentication.router)
app.include_router(users.router)
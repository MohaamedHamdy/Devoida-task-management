from fastapi import FastAPI
from app.database import engine, Base
from .routers import users, authentication, workspace, board, tasks
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()




app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # or specify "http://10.0.2.2:8000"
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def on_startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def root():
    return {"message": "Task Management API is up!"}

app.include_router(authentication.router)
app.include_router(users.router)
app.include_router(workspace.router)
app.include_router(board.router)
app.include_router(tasks.router)
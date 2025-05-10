from fastapi import APIRouter, Depends, HTTPException, status
from ..oauth2 import get_current_user
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession
from typing import List
from .. import database
from ..schemas import User, TaskOut, TaskUpdate, TaskCreate
from ..repository import tasks

router = APIRouter(prefix="/tasks", tags=["Tasks"])



@router.post("/", response_model=TaskOut)
async def create_task(
    task: TaskCreate,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await tasks.create_task(db, task, created_by=current_user["user_id"])


@router.get("/board/{board_id}", response_model=List[TaskOut])
async def get_tasks_by_board(board_id: int, db: AsyncSession = Depends(database.get_db)):
    return await tasks.get_tasks_by_board(db, board_id)


@router.get("/{task_id}", response_model=TaskOut)
async def get_task(task_id: int, db: AsyncSession = Depends(database.get_db)):
    task = await tasks.get_task_by_id(db, task_id)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@router.put("/{task_id}", response_model=TaskOut)
async def update_task(task_id: int, task_data: TaskUpdate, db: AsyncSession = Depends(database.get_db)):
    task = await tasks.update_task(db, task_id, task_data)
    if not task:
        raise HTTPException(status_code=404, detail="Task not found")
    return task


@router.delete("/{task_id}")
async def delete_task(task_id: int, db: AsyncSession = Depends(database.get_db)):
    success = await tasks.delete_task(db, task_id)
    if not success:
        raise HTTPException(status_code=404, detail="Task not found")
    return {"detail": "Task deleted successfully"}


@router.post("/{task_id}/assign/{user_id}")
async def assign_user(task_id: int, user_id: int, db: AsyncSession = Depends(database.get_db)):
    return await tasks.assign_user_to_task(db, task_id, user_id)


@router.delete("/{task_id}/unassign/{user_id}")
async def unassign_user(task_id: int, user_id: int, db: AsyncSession = Depends(database.get_db)):
    success = await tasks.remove_user_from_task(db, task_id, user_id)
    if not success:
        raise HTTPException(status_code=404, detail="Assignment not found")
    return {"detail": "User unassigned from task"}
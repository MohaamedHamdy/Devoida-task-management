from sqlalchemy.orm import Session, joinedload
from sqlalchemy import select, update, delete
# from app.models import Task, TaskAssignment, StatusEnum
from typing import List
from ..models import models 
from ..schemas import TaskCreate, TaskUpdate
from sqlalchemy.ext.asyncio import AsyncSession
from fastapi import HTTPException


async def get_task_by_id(db: AsyncSession, task_id: int):
    result = await db.execute(
        select(models.Task)
        .options(joinedload(models.Task.assignee))  
        .where(models.Task.id == task_id)
    )
    return result.scalar_one_or_none()

async def get_tasks_by_board(db: AsyncSession, board_id: int):
    stmt = select(models.Task).where(models.Task.board_id == board_id).order_by(models.Task.created_at.desc())
    result = await db.execute(stmt)
    return result.scalars().all()


async def create_task(db: AsyncSession, task_data: TaskCreate, created_by: int):
    task = models.Task(
        title=task_data.title,
        description=task_data.description,
        board_id=task_data.board_id,
        due_date=task_data.due_date,
        status=task_data.status,
        created_by=created_by
    )
    db.add(task)
    await db.commit()
    await db.refresh(task)
    return task


async def update_task(db: AsyncSession, task_id: int, task_data: TaskUpdate):
    task = await get_task_by_id(db, task_id)
    if not task:
        return None

    updates = task_data.dict(exclude_unset=True)

    if "status" in updates:
        try:
            updates["status"] = models.StatusEnum(updates["status"])
        except ValueError:
            raise HTTPException(status_code=400, detail=f"Invalid status value: {updates['status']}")

    for field, value in updates.items():
        setattr(task, field, value)

    await db.commit()   
    await db.refresh(task)
    return task

async def delete_task(db: AsyncSession, task_id: int):
    task = await get_task_by_id(db, task_id)
    if not task:
        return False
    await db.delete(task)
    await db.commit()
    return True


async def assign_user_to_task(db: AsyncSession, task_id: int, user_id: int):
    result = await db.execute(
        select(models.Task).where(models.Task.id == task_id)
    )
    task = result.scalar_one_or_none()
    if not task:
        return HTTPException(status_code=404, detail="Task not found")

    task.assigned_to = user_id
    await db.commit()
    await db.refresh(task)
    return task

async def remove_user_from_task(db: AsyncSession, task_id: int, user_id: int):
    result = await db.execute(
        select(models.Task).where(
            models.Task.id == task_id,
            models.Task.assigned_to == user_id
        )
    )
    task = result.scalar_one_or_none()
    if not task:
        return False

    task.assigned_to = None
    await db.commit()
    return True

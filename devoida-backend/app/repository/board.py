from sqlalchemy import select, update, delete
from sqlalchemy.ext.asyncio import AsyncSession
from fastapi import HTTPException
from ..models import models
from ..schemas import BoardCreate, BoardUpdate
from sqlalchemy.orm import joinedload


async def is_workspace_member(db: AsyncSession, user_id: int, workspace_id: int):
    stmt = select(models.WorkspaceMembership).where(
        models.WorkspaceMembership.user_id == user_id,
        models.WorkspaceMembership.workspace_id == workspace_id
    )
    result = await db.execute(stmt)
    return result.scalar_one_or_none() is not None


async def create_board(request: BoardCreate, db: AsyncSession, current_user: dict):
    if not await is_workspace_member(db, current_user["user_id"], request.workspace_id):
        raise HTTPException(status_code=403, detail="You are not a member of this workspace")

    board = models.Board(
        name=request.name,
        description=request.description,
        workspace_id=request.workspace_id,
        created_by=current_user["user_id"]
    )
    try:
        db.add(board)
        await db.commit()
        await db.refresh(board)
    except Exception as e:
        await db.rollback()
        raise HTTPException(status_code=500, detail=f"Error committing to DB: {str(e)}")

    return board


async def get_boards(workspace_id: int, created_by_me: bool, db: AsyncSession, current_user: dict):
    if not await is_workspace_member(db, current_user["user_id"], workspace_id):
        raise HTTPException(status_code=403, detail="Access denied to this workspace")

    stmt = select(models.Board).where(models.Board.workspace_id == workspace_id)

    if created_by_me:
        stmt = stmt.where(models.Board.created_by == current_user["user_id"])

    stmt = stmt.order_by(models.Board.created_at.desc())

    result = await db.execute(stmt)
    return {"Status" : "Success" , "data" : result.scalars().all()}


async def delete_board(board_id: int, db: AsyncSession, current_user: dict):
    stmt = select(models.Board).where(models.Board.id == board_id)
    result = await db.execute(stmt)
    board = result.scalar_one_or_none()

    if not board:
        raise HTTPException(status_code=404, detail="Board not found")
    if board.created_by != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Only the board creator can delete")

    await db.delete(board)
    await db.commit()
    return {"detail": "Board deleted successfully"}

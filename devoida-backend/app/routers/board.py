
from fastapi import APIRouter, Depends
from typing import List
from sqlalchemy.ext.asyncio import AsyncSession
from .. import database
from ..schemas import BoardCreate, BoardUpdate, BoardOut, BoardListResponse
from ..oauth2 import get_current_user
from ..repository import board

router = APIRouter(prefix="/boards", tags=["Boards"])


@router.post("/", response_model=BoardOut)
async def create_board(
    request: BoardCreate,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await board.create_board(request, db, current_user)


@router.get("/{workspace_id}", response_model=BoardListResponse)
async def get_boards(
    workspace_id: int,
    created_by_me: bool = False,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await board.get_boards(workspace_id, created_by_me, db, current_user)


@router.put("/{board_id}", response_model=BoardOut)
async def update_board(
    board_id: int,
    request: BoardUpdate,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await board.update_board(board_id, request, db, current_user)


@router.delete("/{board_id}")
async def delete_board(
    board_id: int,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await board.delete_board(board_id, db, current_user)

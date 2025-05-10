from fastapi import APIRouter, Depends, status
from .. import schemas, database
from app.models import models
from ..repository import workspace
from sqlalchemy.orm import Session
from sqlalchemy.ext.asyncio import AsyncSession
from ..oauth2 import get_current_user


router = APIRouter(
    prefix="/workspace",
    tags=['Workspace']
)


@router.post('/', status_code=status.HTTP_201_CREATED)
async def create_workspace(
      request: schemas.WorkSpace,
      db:Session = Depends(database.get_db), 
      current_user: dict = Depends(get_current_user)):
    return await workspace.create_workspace(request, db, current_user)

@router.get('/', status_code=status.HTTP_200_OK)
async def get_created_workspaces(
      db:Session = Depends(database.get_db), 
      current_user: dict = Depends(get_current_user)):
    return await workspace.get_created_workspaces( db, current_user)

@router.post("/add-member")
async def add_member_to_workspace(
    request: schemas.AddToWorkspace,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    return await workspace.add_member_to_workspace(request.workspace_id, request.user_id, db, current_user)
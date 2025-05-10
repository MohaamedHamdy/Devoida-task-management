from ..schemas import WorkSpace
from ..models import models
from sqlalchemy import select, delete
from .. import database
from fastapi import Depends, HTTPException
from ..oauth2 import get_current_user
from sqlalchemy.orm import joinedload

from sqlalchemy.ext.asyncio import AsyncSession

async def create_workspace(request: WorkSpace, db: AsyncSession, current_user: dict):
    new_workspace = models.Workspace(
        name = request.name,
        description = request.description,
        created_by = current_user["user_id"]
    )
    db.add(new_workspace)

    await db.flush() 

    creator_membership = models.WorkspaceMembership(
        user_id=current_user["user_id"],
        workspace_id=new_workspace.id
    )

    db.add(creator_membership)

    await db.commit()
    await db.refresh(new_workspace)
    return new_workspace

async def get_created_workspaces(db: AsyncSession, current_user: dict):
    # print(current_user["user_id"])
    # print(current_user)
    result = await db.execute(select(models.Workspace).filter(models.Workspace.created_by == current_user["user_id"]))

    return {"Status" : "Success", "data": result.scalars().all()}


async def get_all_workspaces_for_user(db: AsyncSession, current_user: dict):
    stmt = (
        select(models.Workspace)
        .join(models.WorkspaceMembership)
        .where(models.WorkspaceMembership.user_id == current_user["user_id"])
        .options(joinedload(models.Workspace.creator))
    )
    result = await db.execute(stmt)
    workspaces = result.scalars().all()
    return {"Status" : "Success", "data" : workspaces}

async def add_member_to_workspace(
    workspace_id: int,
    user_id: int,
    db: AsyncSession = Depends(database.get_db),
    current_user: dict = Depends(get_current_user)
):
    stmt = select(models.Workspace).where(models.Workspace.id == workspace_id)
    result = await db.execute(stmt)
    workspace = result.scalar_one_or_none()

    if not workspace:
        raise HTTPException(status_code=404, detail="Workspace not found")

    if workspace.created_by != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="Only creator can add members")
    
    user = await db.execute(select(models.User).where(models.User.id == user_id))

    if user.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="User not found")

    check_stmt = select(models.WorkspaceMembership).where(
        models.WorkspaceMembership.user_id == user_id,
        models.WorkspaceMembership.workspace_id == workspace_id
    )

    check_result = await db.execute(check_stmt)
    if check_result.scalar_one_or_none():
        raise HTTPException(status_code=400, detail="User already a member")

    
    new_member = models.WorkspaceMembership(user_id=user_id, workspace_id=workspace_id)
    db.add(new_member)
    await db.commit()
    await db.refresh(new_member)
    return {"detail": "User added to workspace"}
    
    
async def get_all_members_of_workspace(workspace_id : int, db: AsyncSession):
    stmt = (
        select(models.User)
        .join(models.WorkspaceMembership)
        .where(models.WorkspaceMembership.workspace_id == workspace_id)
    )
    result = await db.execute(stmt)
    members = result.scalars().all()
    return {"Status" : "Success", "data" : members}


async def delete_user_from_workspace(workspace_id : int, 
                                     user_id : int, 
                                     db: AsyncSession, 
                                     current_user: dict):
    result = await db.execute(
        select(models.Workspace).where(models.Workspace.id == workspace_id)
    )
    workspace = result.scalar_one_or_none()

    if not workspace:
        raise HTTPException(status_code=404, detail="Workspace not found")

    if workspace.created_by != current_user["user_id"]:
        raise HTTPException(status_code=403, detail="You are not the creator of this workspace")

    if user_id == current_user["user_id"]:
        raise HTTPException(status_code=400, detail="You cannot remove yourself from your own workspace")
    
    user = await db.execute(select(models.User).where(models.User.id == user_id))
    
    if user.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="User not found")
    

    membership = await db.execute(
    select(models.WorkspaceMembership).where(
        models.WorkspaceMembership.user_id == user_id,
        models.WorkspaceMembership.workspace_id == workspace_id
        )
    )
    if membership.scalar_one_or_none() is None:
        raise HTTPException(status_code=404, detail="User is not a member of this workspace")


    await db.execute(
        delete(models.WorkspaceMembership).where(
            models.WorkspaceMembership.user_id == user_id,
            models.WorkspaceMembership.workspace_id == workspace_id
        )
    )
    await db.commit()
    return {"detail": "User removed from workspace successfully"}
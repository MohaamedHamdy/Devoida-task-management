from ..schemas import WorkSpace
from ..models import models
from sqlalchemy import select


from sqlalchemy.ext.asyncio import AsyncSession

async def create_workspace(request: WorkSpace, db: AsyncSession, current_user: dict):
    new_workspace = models.Workspace(
        name = request.name,
        description = request.description,
        created_by = current_user["user_id"]
    )
    db.add(new_workspace)
    await db.commit()
    await db.refresh(new_workspace)
    return new_workspace

async def get_created_workspaces(db: AsyncSession, current_user: dict):
    result = await db.execute(select(models.Workspace).filter(models.Workspace.created_by == current_user["user_id"]))
    return result.scalars().all()


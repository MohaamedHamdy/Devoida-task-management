from sqlalchemy import (
    Column, Integer, String, Text, ForeignKey, TIMESTAMP, DateTime, UniqueConstraint, Enum, Date
)

from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from ..database import Base
import enum


class StatusEnum(str, enum.Enum):
    todo = 'To-Do'
    in_progress = 'In Progress'
    done = 'Done'


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, nullable=False)
    username = Column(String(100), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    profile_picture = Column(String(255), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    created_workspaces = relationship("Workspace", back_populates="creator")
    memberships = relationship("WorkspaceMembership", back_populates="user")
    created_boards = relationship("Board", back_populates="creator")
    created_tasks = relationship(
        "Task",
        back_populates="creator",
        foreign_keys="Task.created_by",
    )
    
    assigned_tasks = relationship(
        "Task",
        back_populates="assignee",
        foreign_keys="Task.assigned_to",
    )






class Workspace(Base):
    __tablename__ = "workspaces"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(Text)
    created_by = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"))
    created_at = Column(TIMESTAMP, server_default=func.now())

    creator = relationship("User", back_populates="created_workspaces")
    members = relationship("WorkspaceMembership", back_populates="workspace")
    boards = relationship("Board", back_populates="workspace")

class WorkspaceMembership(Base):
    __tablename__ = "workspace_memberships"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    workspace_id = Column(Integer, ForeignKey("workspaces.id", ondelete="CASCADE"), nullable=False)
    joined_at = Column(TIMESTAMP, server_default=func.now())

    __table_args__ = (UniqueConstraint("user_id", "workspace_id"),)

    user = relationship("User", back_populates="memberships")
    workspace = relationship("Workspace", back_populates="members")


class Board(Base):
    __tablename__ = "boards"

    id = Column(Integer, primary_key=True, index=True)
    workspace_id = Column(Integer, ForeignKey("workspaces.id", ondelete="CASCADE"), nullable=False)
    name = Column(String(100), nullable=False)
    description = Column(Text, nullable=True)
    created_by = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"))
    created_at = Column(TIMESTAMP, server_default=func.now())

    workspace = relationship("Workspace", back_populates="boards")
    creator = relationship("User", back_populates="created_boards")
    tasks = relationship("Task", back_populates="board")


class Task(Base):
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    board_id = Column(Integer, ForeignKey("boards.id", ondelete="CASCADE"), nullable=False)
    title = Column(String(255), nullable=False)
    description = Column(Text)
    status = Column(Enum(StatusEnum), default=StatusEnum.todo)
    due_date = Column(Date)
    created_by = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"))
    assigned_to = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"), nullable=True)  # 👈 Add this
    created_at = Column(TIMESTAMP, server_default=func.now())

    board = relationship("Board", back_populates="tasks")
    creator = relationship(
        "User",
        back_populates="created_tasks",
        foreign_keys=[created_by],
    )

    assignee = relationship(
        "User",
        back_populates="assigned_tasks",
        foreign_keys=[assigned_to],
    )

# class Task(Base):
#     __tablename__ = "tasks"

#     id = Column(Integer, primary_key=True, index=True)
#     board_id = Column(Integer, ForeignKey("boards.id", ondelete="CASCADE"), nullable=False)
#     title = Column(String(255), nullable=False)
#     description = Column(Text)
#     status = Column(Enum(StatusEnum), default=StatusEnum.todo)
#     due_date = Column(Date)
#     created_by = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"))
#     created_at = Column(TIMESTAMP, server_default=func.now())

#     board = relationship("Board", back_populates="tasks")
#     creator = relationship("User", back_populates="created_tasks")
#     assignees = relationship("TaskAssignment", back_populates="task")

# class TaskAssignment(Base):
#     __tablename__ = "task_assignments"

#     id = Column(Integer, primary_key=True, index=True)
#     task_id = Column(Integer, ForeignKey("tasks.id", ondelete="CASCADE"), nullable=False)
#     user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
#     assigned_at = Column(TIMESTAMP, server_default=func.now())

#     __table_args__ = (UniqueConstraint("task_id", "user_id"),)

#     task = relationship("Task", back_populates="assignees")
#     user = relationship("User", back_populates="assigned_tasks")

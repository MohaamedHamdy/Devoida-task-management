from sqlalchemy import (
    Column, Integer, String, Text, ForeignKey, TIMESTAMP, DateTime, UniqueConstraint
)

from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from ..database import Base
import enum

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String(255), unique=True, nullable=False)
    username = Column(String(100), nullable=False)
    password_hash = Column(String(255), nullable=False)
    profile_picture = Column(String(255), nullable=True)
    created_at = Column(DateTime(timezone=True), server_default=func.now())

    created_workspaces = relationship("Workspace", back_populates="creator", foreign_keys='Workspace.created_by')



class Workspace(Base):
    __tablename__ = "workspaces"
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(Text)
    created_by = Column(Integer, ForeignKey("users.id", ondelete="SET NULL"))
    created_at = Column(TIMESTAMP, server_default=func.now())

    creator = relationship("User", back_populates="created_workspaces")
    members = relationship("WorkspaceMembership", back_populates="workspace")

class WorkspaceMembership(Base):
    __tablename__ = "workspace_memberships"
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id", ondelete="CASCADE"), nullable=False)
    workspace_id = Column(Integer, ForeignKey("workspaces.id", ondelete="CASCADE"), nullable=False)
    joined_at = Column(TIMESTAMP, server_default=func.now())

    __table_args__ = (UniqueConstraint("user_id", "workspace_id"),)

    user = relationship("User")
    workspace = relationship("Workspace", back_populates="members")
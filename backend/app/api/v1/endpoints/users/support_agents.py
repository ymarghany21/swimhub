from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.db.database import get_db
from app.models import Agent  # Import the Agent model
from app.schemas.profiles.agent import agentInfo, AgentResponse  # Import the schemas
from datetime import datetime

router = APIRouter(prefix="/agents", tags=["agents"])

@router.post("/", response_model=AgentResponse)
def create_agent(agent: agentInfo, db: Session = Depends(get_db)):
    """
    Create a new agent.
    
    Args:
        agent (agentInfo): The agent data.
        db (Session): The database session.
    
    Returns:
        AgentResponse: The created agent's data.
    
    Raises:
        HTTPException: If the user ID is invalid.
    """
    # Create a new agent object
    new_agent = Agent(
        department=agent.department,
        created_at=datetime.utcnow(),
        updated_at=datetime.utcnow(),
        user_id=1  # Replace with the actual user ID (e.g., from authentication)
    )
    
    # Add the new agent to the database
    db.add(new_agent)
    db.commit()
    db.refresh(new_agent)
    
    # Return the agent's data in the AgentResponse format
    return new_agent

@router.get("/{agent_id}", response_model=AgentResponse)
def get_agent(agent_id: int, db: Session = Depends(get_db)):
    """
    Get an agent by ID.
    
    Args:
        agent_id (int): The ID of the agent.
        db (Session): The database session.
    
    Returns:
        AgentResponse: The agent's data.
    
    Raises:
        HTTPException: If the agent is not found.
    """
    agent = db.query(Agent).filter(Agent.id == agent_id).first()
    if not agent:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Agent not found."
        )
    return agent

@router.get("/", response_model=list[AgentResponse])
def get_all_agents(db: Session = Depends(get_db)):
    """
    Get all agents.
    
    Args:
        db (Session): The database session.
    
    Returns:
        List[AgentResponse]: A list of all agents.
    """
    agents = db.query(Agent).all()
    return agents

@router.put("/{agent_id}", response_model=AgentResponse)
def update_agent(agent_id: int, agent: agentInfo, db: Session = Depends(get_db)):
    """
    Update an agent by ID.
    
    Args:
        agent_id (int): The ID of the agent.
        agent (agentInfo): The updated agent data.
        db (Session): The database session.
    
    Returns:
        AgentResponse: The updated agent's data.
    
    Raises:
        HTTPException: If the agent is not found.
    """
    # Find the agent to update
    agent_to_update = db.query(Agent).filter(Agent.id == agent_id).first()
    if not agent_to_update:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Agent not found."
        )
    
    # Update the agent's data
    agent_to_update.department = agent.department
    agent_to_update.updated_at = datetime.utcnow()
    
    # Commit the changes to the database
    db.commit()
    db.refresh(agent_to_update)
    
    # Return the updated agent's data
    return agent_to_update

@router.delete("/{agent_id}")
def delete_agent(agent_id: int, db: Session = Depends(get_db)):
    """
    Delete an agent by ID.
    
    Args:
        agent_id (int): The ID of the agent.
        db (Session): The database session.
    
    Returns:
        dict: A confirmation message.
    
    Raises:
        HTTPException: If the agent is not found.
    """
    # Find the agent to delete
    agent_to_delete = db.query(Agent).filter(Agent.id == agent_id).first()
    if not agent_to_delete:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Agent not found."
        )
    
    # Delete the agent from the database
    db.delete(agent_to_delete)
    db.commit()
    
    return {"message": "Agent deleted successfully."}
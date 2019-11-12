from sqlalchemy.orm import Session

from models import User, Vehicle

def get_vehicles_by_owner_id(db: Session, owner_id: int):
    return db.query(Vehicle).filter(Vehicle.owner_id == owner_id).order_by(Vehicle.distance).all()

def get_user_by_username(db: Session, username: str):
    return db.query(User).filter(User.username == username).first()

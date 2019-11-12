from typing import List

from pydantic import BaseModel


class VehicleBase(BaseModel):
    distance: int = None

class Vehicle(VehicleBase):
    id: int
    owner_id: int
    
    class Config:
        orm_mode = True

class UserToken(BaseModel):
    token: str

class UserBase(BaseModel):
    username: str

class UserAuth(UserBase):
    password: str

class User(UserBase):
    id: int
    vehicles: List[Vehicle] = []
    
    class Config:
        orm_mode = True
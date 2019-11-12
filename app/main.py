import uvicorn

from typing import List

from fastapi import Depends, FastAPI, HTTPException, Header
from sqlalchemy.orm import Session
from sqlalchemy import event, DDL

from schemas import User, UserAuth, UserToken, Vehicle
from models import Base
from crud import get_vehicles_by_owner_id, get_user_by_username
from database import SessionLocal, engine
from utils import encode_auth_token, decode_auth_token

app = FastAPI()

@app.post("/token/", response_model=UserToken)
def get_token(user: UserAuth):
    db = SessionLocal()
    db_user = get_user_by_username(db, username=user.username)
    if not db_user or db_user.password != user.password:
        raise HTTPException(status_code=401, detail="Unauthorized")
    else:
        auth_token = encode_auth_token(db_user.id)
        tokenObj = UserToken(token = auth_token.decode())
        return tokenObj

@app.get("/vehicles/", response_model=List[Vehicle])
def read_vehicles(authorization: str = Header(None)):

    if authorization:
        auth_token = authorization.split(" ")[1]
    else:
        auth_token = ''
    
    if auth_token:
        resp = decode_auth_token(auth_token)
        if not isinstance(resp, str):
            db = SessionLocal()
            return get_vehicles_by_owner_id(db, owner_id=resp)
        
        raise HTTPException(status_code=403, detail=resp)
    else:
        raise HTTPException(status_code=403, detail='Provide a valid token')

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8080)

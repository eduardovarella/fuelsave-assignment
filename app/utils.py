import jwt
import datetime

def decode_auth_token(auth_token):
    try:
        payload = jwt.decode(auth_token, 'fuelsave2019')
        return payload['sub']
    except jwt.ExpiredSignatureError:
        return 'Signature expired. Please log in again.'
    except jwt.InvalidTokenError:
        return 'Invalid token. Please log in again.'

def encode_auth_token(user_id):
    payload = {
        'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=10),
        'iat': datetime.datetime.utcnow(),
        'sub': user_id
    }
    return jwt.encode(
        payload,
        'fuelsave2019',
        algorithm='HS256'
    )

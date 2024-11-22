from functools import wraps

from flask import request

from entity.AuthJWT import AuthJWT
from exceptions.AuthException import AuthException


# decorator for verifying the JWT
def token_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token_json = None
        if 'token' in request.headers:
            token_json = request.headers['token']
        if not token_json:
            raise AuthException('Authentication token missing.')
        token = AuthJWT().decode(token_json)
        if token is None:
            raise AuthException('Authentication failed.')
        return f(*args, token, **kwargs)
    return decorated
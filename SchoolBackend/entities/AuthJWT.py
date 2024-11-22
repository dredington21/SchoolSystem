from datetime import datetime, timedelta

import jwt

from config import Config


class AuthJWT:

    def __init__(self, user_id: str = None, role: str = None):
        self.user_id = user_id
        self.expiry_datetime = datetime.utcnow() + timedelta(hours=Config.TOKEN_DURATION_HOURS)
        self.role = role

    def encode(self) -> str:
        payload = {
            'usr': self.user_id,
            'exp': self.expiry_datetime,
            'role': self.role
        }
        return jwt.encode(payload, Config.SECRET, algorithm='HS512')

    def decode(self, token_string: str) -> 'AuthJWT | None':
        try:
            token_bytes = token_string.encode('utf-8')
            token_dict = jwt.decode(token_bytes, Config.SECRET, algorithms=['HS512'])
            self.user_id = token_dict['usr']
            self.expiry_datetime = token_dict['exp']
            self.role = token_dict['role']
            return self
        except (jwt.ExpiredSignatureError, jwt.InvalidTokenError):
            return None
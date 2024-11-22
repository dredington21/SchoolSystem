import config.Config as Config
import hashlib
import repositories.AuthRepository as AuthRepository
from entity.AuthJWT import AuthJWT
from entity.AuthUser import AuthUser
from entity.enum.PermissionsGroup import PermissionsGroup
from exceptions.AuthException import AuthException
from exceptions.RestException import RestException
from repositories import ResidentRepository
from utilities.Utility import is_valid_uuid4


def hash_password(password: str) -> str:
    return hashlib.sha512(str.encode(password + Config.SALT), usedforsecurity=True).hexdigest()


def get_user(username):
    if not username:
        raise AuthException('Username must be provided.')
    user = AuthRepository.get_user(username)
    if not user:
        raise AuthException('No such user.')
    return user


def login(username, password):
    if not username or not password:
        raise AuthException('Username of password not provided.')
    auth_user = AuthRepository.get_user(username)
    if not auth_user:
        raise AuthException('Invalid username or password.')
    stored_hash = auth_user.passwordhash
    if stored_hash != hash_password(password):
        raise AuthException('Invalid username or password.')
    permissions_group = auth_user.permissionsgroup
    return AuthJWT(username, permissions_group).encode()


def register(username, password, resident_id):
    if not username or not password:
        raise AuthException('Username or password are not provided.')
    if len(username) > 128:
        raise AuthException('Username is too long (max 128).')
    if resident_id and not is_valid_uuid4(resident_id):
        raise AuthException('Invalid resident ID.')
    if AuthRepository.get_user(username):
        raise AuthException('Username already exists.')
    if AuthRepository.get_user_by_resident_id(resident_id):
        raise AuthException('Resident ID already registered.')
    if resident_id and not ResidentRepository.get_resident(resident_id):
        raise AuthException('No such resident.')
    auth_user = AuthUser(username, hash_password(password), PermissionsGroup.USER, resident_id)
    AuthRepository.create_auth_user(auth_user)
    return AuthJWT(username, PermissionsGroup.USER if resident_id else PermissionsGroup.GUEST).encode()


def delete_user(username):
    if not username:
        raise RestException('Username not provided.')
    user = AuthRepository.get_user(username)
    if not user:
        raise RestException('No such user.')
    AuthRepository.delete_auth_user(user)
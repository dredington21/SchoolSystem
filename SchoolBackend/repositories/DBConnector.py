import psycopg2
import psycopg2.extras

import config.Config
from entity.enum.PermissionsGroup import PermissionsGroup

con_admin = None
con_user = None
con_guest = None


def get_connection(group: PermissionsGroup = PermissionsGroup.GUEST):
    global con_admin
    global con_user
    global con_guest
    match group:
        case PermissionsGroup.GUEST:
            if con_guest is None:
                con_guest = psycopg2.connect(host=config.Config.DATABASE_HOST,
                                             database=config.Config.DATABASE_NAME,
                                             user=config.Config.DATABASE_USER_GUEST,
                                             password=config.Config.DATABASE_USER_GUEST_PW)
                con_guest.autocommit = True
            return con_guest
        case PermissionsGroup.USER:
            if con_user is None:
                con_user = psycopg2.connect(host=config.Config.DATABASE_HOST,
                                            database=config.Config.DATABASE_NAME,
                                            user=config.Config.DATABASE_USER_USER,
                                            password=config.Config.DATABASE_USER_USER_PW)
                con_user.autocommit = True
            return con_user
        case PermissionsGroup.ADMIN:
            if con_admin is None:
                con_admin = psycopg2.connect(host=config.Config.DATABASE_HOST,
                                             database=config.Config.DATABASE_NAME,
                                             user=config.Config.DATABASE_USER_ADMIN,
                                             password=config.Config.DATABASE_USER_ADMIN_PW)
                con_admin.autocommit = True
            return con_admin


def close_connections():
    if con_admin is not None:
        con_admin.close()
    if con_user is not None:
        con_user.close()
    if con_guest is not None:
        con_guest.close()


def init_db():
    with open(config.Config.DATABASE_SCHEMA, 'r') as schema:
        schema_script = schema.read()
    psycopg2.extras.register_uuid()
    con = get_connection(PermissionsGroup.ADMIN)
    con.cursor().execute(schema_script)
    con.commit()
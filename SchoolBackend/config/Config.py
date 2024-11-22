import os

from entity.enum import PermissionsGroup

project_directory = project_folder = os.path.abspath(
    os.path.join(os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                              os.pardir)), os.pardir))

# Database
DATABASE_HOST = 'localhost'
DATABASE_NAME = 'School'
DATABASE_SCHEMA = project_folder + os.path.sep + 'schema.sql'
DATABASE_USER_STUDENT = 'student'
DATABASE_USER_STUDENT_PW = 'password1'
DATABASE_USER_ADVISOR = 'advisor'
DATABASE_USER_ADVISOR_PW = 'password2'
DATABASE_USER_STAFF = 'staff'
DATABASE_USER_STAFF_PW = 'password3'
DATABASE_USER_INSTRUCTOR = 'instructor'
DATABASE_USER_INSTRUCTOR_PW = 'password4'

# Auth
SECRET = '294eed58714d8f8c3aa557163d44674c53d88a1a8e433b1328a389fc4d945069'
SALT = 'af892c065d3967a90788a93895c99569'
TOKEN_DURATION_HOURS = 1

# GA Default Admin Info:
# Username: GOD
#password: password
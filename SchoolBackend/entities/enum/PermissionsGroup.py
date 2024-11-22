def from_string(permissions_group_string):
    upper_group = permissions_group_string.upper()
    match upper_group:
        case 'STUDENT':
            return PermissionsGroup.STUDENT
        case 'INSTRUCTOR':
            return PermissionsGroup.INSTRUCTOR
        case 'ADVISOR':
            return PermissionsGroup.ADVISOR
        case 'STAFF':
            return PermissionsGroup.STAFF
        
        case _:
            raise ValueError('No such PermissionsGroup.')


class PermissionsGroup:
    STUDENT = 'STUDENT'
    INSTRUCTOR = 'INSTRUCTOR'
    ADVISOR = 'ADVISOR'
    STAFF = 'STAFF'
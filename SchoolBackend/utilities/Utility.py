import uuid


def generate_uuid4():
    return uuid.uuid4()


def is_valid_uuid4(id):
    try:
        uuid.UUID(id, version=4)
    except ValueError as e:
        return False
    return True
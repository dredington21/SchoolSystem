from exceptions.RestException import RestException


class AuthException(RestException):
    def __init__(self, message, http_code=401):
        self.message = message
        self.http_code = http_code
        super().__init__(self.message, self.http_code)
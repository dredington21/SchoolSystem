from flask import jsonify
from werkzeug.exceptions import BadRequest

from exceptions import RestException


def configure_controller_advice(app):
    @app.errorhandler(Exception)
    def handle_exception(error):
        print(error)
        code = 503
        if isinstance(error, RestException.RestException):
            code = error.http_code
        elif isinstance(error, BadRequest):
            code = 400

        response = {
            'error': {
                'code': code,
                'description': str(error)
            }
        }

        return jsonify(response), code
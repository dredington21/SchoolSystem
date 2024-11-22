from flask import Flask
from flask_cors import CORS
from flask_restful import Api
from flasgger import Swagger


app = Flask(__name__)
CORS(app)
api = Api(app)
SWAGGER_TEMPLATE = {"securityDefinitions": {"APIKeyHeader": {"type": "apiKey", "name": "token", "in": "header"}}}
swagger = Swagger(app, template=SWAGGER_TEMPLATE)

configure_controller_advice(app)





DB.init_db()

if __name__ == '__main__':
    app.run(debug=True)
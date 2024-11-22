from flask import request, jsonify
from flask_restful import Resource

import services.AuthService as AuthService
from annotations.TokenRequired import token_required

from entity.enum.PermissionsGroup import PermissionsGroup
from exceptions.AuthException import AuthException
from exceptions.RestException import RestException


class Login(Resource):
    def post(self):
        """
        Login
        ---
        tags:
          - auth
        parameters:
          - name: username
            in: formData
          - name: password
            in: formData
        responses:
          200:
            schema:
              type: object
        """
        username = request.form.get('username')
        password = request.form.get('password')

        return jsonify({'token': AuthService.login(username, password)})


class Register(Resource):
    def post(self):
        """
        Register
        ---
        tags:
          - auth
        parameters:
          - name: username
            in: formData
          - name: password
            in: formData
          - name: resident_id
            in: formData
        responses:
          200:
            schema:
              type: object
        """
        username = request.form.get('username')
        password = request.form.get('password')
        resident_id = request.form.get('resident_id')

        return jsonify({'token': AuthService.register(username, password, resident_id)})


class DeleteUser(Resource):
    @token_required
    def post(self, token):
        """
        Delete User
        ---
        tags:
          - auth
        security:
          - APIKeyHeader: ['x-access-token']
        parameters:
          - name: username
            in: formData
        responses:
          200:
            schema:
              type: object
        """
        username = request.form.get('username')
        if token.permissions_group < PermissionsGroup.ADMIN:
            raise AuthException('Unauthorized.')
        if token.username == username:
            raise RestException('Cannot delete self.')

        AuthService.delete_user(username)
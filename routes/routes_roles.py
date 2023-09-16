from flask import Blueprint, jsonify, render_template, request, redirect, url_for, flash
from models.roles import Rol
from utils.Logger import Logger

# objeto del controlador usuario
rol = Rol()

roles = Blueprint('roles', __name__, template_folder='templates')

@roles.route('/roles')
def getRoles():
    roles = rol.get_roles()
    if roles !=None:
        return jsonify({"roles": roles})
    else:
        return jsonify({"mensaje": "No existe roles"})
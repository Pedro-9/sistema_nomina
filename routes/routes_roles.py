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
    
# Ruta para obtener una empresa
# ----------------------------
@roles.route('/roles/<string:id_rol>')
def getEmpresa(id_rol):
    row = rol.get_rol(id_rol)
    if row!=None:
        return jsonify({"roles": row})
    else:
        return jsonify({"mensaje": "No existe rol"})
from flask import Blueprint, jsonify, render_template, request, redirect, url_for, flash
from models.usuario import Usuario
from utils.Logger import Logger

# objeto del controlador usuario
user = Usuario()

usuario = Blueprint('usuario', __name__, template_folder='templates')

@usuario.route('/')
def index_login():
    return render_template('login.html')


@usuario.route('/dashboard')
def dashboard():
    usuarios = user.get_usuarios()
    return render_template('dashboard_admin.html')


@usuario.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        id_empresa = request.form['id_empresa']
        var_usuario = request.form['usuario']
        password = request.form['password']
        try:
            usuario = user.validar_usuario(var_usuario, id_empresa, password)
            if usuario != None:
                Logger.add_to_log("info",f"usuario existente id_empresa:{id_empresa} usuario: {var_usuario}")
                return redirect(url_for('usuario.dashboard'))
            else:
                Logger.add_to_log("info","usuario no existe")
                return redirect(url_for('usuario.index_login'))
        except Exception as e:
            return redirect(url_for('usuario.index_login'))


@usuario.route('/usuarios')
def getUsuarios():
    usuarios = user.get_usuarios()
    if usuarios !=None:
        return jsonify({"usuarios": usuarios})
    else:
        return jsonify({"mensaje": "No existe usuarios"})


@usuario.route('/usuarios/<string:id_usuario>')
def getUsuario(id_usuario):
    usuario = user.get_usuario(id_usuario)
    if usuario!=None:
        return jsonify({"Usuario": usuario})
    else:
        return jsonify({"mensaje": "Usuario no existe"})



    
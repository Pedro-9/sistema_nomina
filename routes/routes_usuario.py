from flask import Blueprint, jsonify, render_template, request, redirect, url_for, flash
from models.usuario import Usuario
from utils.Logger import Logger

# objeto del controlador usuario
user = Usuario()

usuario = Blueprint('usuario', __name__, template_folder='templates')

@usuario.route('/')
def index_login():
    return render_template('login.html')


@usuario.route('/show_users')
def mostrar_usuarios():
     return render_template('usuarios.html')

@usuario.route('/dashboard')
def dashboard():
    return render_template("dashboard_admin.html")

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
                flash('Usuario incorrecto')
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


@usuario.route('/insert_usuario', methods=['POST'])
def insertUsuario():
    if request.method == 'POST':
        var_usuario = request.json['usuario']
        password = request.json['password']
        rol = request.json['rol']
        try:
            response = user.insert_usuario(var_usuario,password,rol)
            if response == True:
                Logger.add_to_log("info",f"Usuario agregado exitosamente -->{var_usuario}")
                return jsonify({"mensaje": "Usuario agregado exitosamente"})
            elif response == False:
                Logger.add_to_log("info","Usuario ya existe")
                return jsonify({"mensaje": "El usuario ya existe"})
        except Exception as e:
            return redirect(url_for('usuario.dashboard'))

@usuario.route('/update_usuario', methods=['POST'])
def updateUsuario():
    if request.method == 'POST':
        var_usuario = request.json['usuario']
        password = request.json['password']
        rol = request.json['rol']
        id = request.json['id']

        try:
            response = user.update_usuario(var_usuario,password, rol, id)
            if response == True:
                Logger.add_to_log("info",f"Usuario actualizado exitosamente -->{var_usuario}")
                return jsonify({"mensaje": "Usuario actualizado exitosamente"})
            elif response == False:
                Logger.add_to_log("info","Usuario ya existe")
                return jsonify({"mensaje": "Error al actualizar registro"})
        except Exception as e:
            return redirect(url_for('usuario.dashboard'))
    

@usuario.route('/delete_usuario/<string:id>', methods=['POST', 'GET'])
def deleteUsuario(id):
    try:
            response = user.delete_usuario(id,'1')
            if response == True:
                Logger.add_to_log("info",f"Usuario eliminado exitosamente con id -->{id}")
                return jsonify({"mensaje": "Usuario eliminado exitosamente"})
            elif response == False:
                Logger.add_to_log("info","Error al eliminar registro")
                return jsonify({"mensaje": "Error al eliminar registro"})
    except Exception as e:
        return redirect(url_for('usuario.dashboard'))

from flask import Blueprint, jsonify, render_template, request, redirect, url_for, flash
from flask_login import login_user, login_required, logout_user
from models.usuario import Usuario
from models.empresa import Empresa
from utils.Logger import Logger

# Objeto del controlador usuario
# ------------------------------
user = Usuario()
emp = Empresa()

usuario = Blueprint('usuario', __name__, template_folder='templates')

# Ruta principal 
# --------------
@usuario.route('/')
def index_login():
    return render_template('login.html')

# Ruta para el inicio de sesion
# -----------------------------
@usuario.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        id_empresa = request.form['id_empresa']
        var_usuario = request.form['usuario']
        password = request.form['password']
        try:

            logged_user = user.validar_usuario(var_usuario, id_empresa, password)
            if logged_user != None:
                if logged_user.password:
                    login_user(logged_user)
                    return redirect(url_for('usuario.dashboard'))
                else:
                    flash('Usuario incorrecto')
                    return redirect(url_for('usuario.index_login'))
            else:
                flash('Usuario no existe')
                Logger.add_to_log("info","usuario no existe")
                return redirect(url_for('usuario.index_login'))

        except Exception as e:
            return redirect(url_for('usuario.index_login'))

# Ruta para cerrar sesion del navegador
# -------------------------------------
@usuario.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('usuario.index_login'))

# Ruta para llamar al template usuarios
# --------------------------------------
@usuario.route('/show_users')
@login_required
def mostrar_usuarios():
     return render_template('usuarios.html')

# Ruta para mostrar dashboard de administrador
# --------------------------------------------
@usuario.route('/dashboard')
@login_required
def dashboard():
    return render_template("dashboard_admin.html")

# Ruta para obtener todos los usuarios
# ------------------------------------
@usuario.route('/usuarios')
@login_required
def getUsuarios():
    usuarios = user.get_usuarios()
    if usuarios !=None:
        return jsonify({"usuarios": usuarios})
    else:
        return jsonify({"mensaje": "No existe usuarios"})

# Ruta para obtener un usuario
# ----------------------------
@usuario.route('/usuarios/<string:id_usuario>')
@login_required
def getUsuario(id_usuario):
    usuario = user.get_usuario(id_usuario)
    if usuario!=None:
        return jsonify({"Usuario": usuario})
    else:
        return jsonify({"mensaje": "Usuario no existe"})

# Ruta para insertar usuario nuevo
# --------------------------------
@usuario.route('/insert_usuario', methods=['POST'])
@login_required
def insertUsuario():
    if request.method == 'POST':
        var_usuario = request.json['usuario']
        password = request.json['password']
        rol = request.json['rol']
        empresa = request.json['empresa']
        try:
            response = user.insert_usuario(var_usuario,password,rol, empresa)
            if response == True:
                emp.update_id_usuario(user.get_ultimo_id(), empresa)
                Logger.add_to_log("info",f"Usuario agregado exitosamente -->{var_usuario}")
                return jsonify({"mensaje": "Usuario agregado exitosamente"})
            elif response == False:
                Logger.add_to_log("info","Usuario ya existe")
                return jsonify({"mensaje": "El usuario ya existe"})
        except Exception as e:
            return redirect(url_for('usuario.dashboard'))

# Ruta para actualizar un usuario existente
# -----------------------------------------
@usuario.route('/update_usuario', methods=['POST'])
@login_required
def updateUsuario():
    if request.method == 'POST':
        var_usuario = request.json['usuario']
        password = request.json['password']
        rol = request.json['rol']
        id = request.json['id']
        id_empresa = request.json['empresa']

        try:
            response = user.update_usuario(var_usuario,password, rol, id_empresa, id)
            if response == True:
                Logger.add_to_log("info",f"Usuario actualizado exitosamente -->{var_usuario}")
                return jsonify({"mensaje": "Usuario actualizado exitosamente"})
            elif response == False:
                Logger.add_to_log("info","Usuario ya existe")
                return jsonify({"mensaje": "Error al actualizar registro"})
        except Exception as err:
            Logger.add_to_log('error', err)
            return redirect(url_for('usuario.dashboard'))
    
# Ruta para eliminar un usuario especifico
# ----------------------------------------
@usuario.route('/delete_usuario/<string:id>', methods=['POST', 'GET'])
@login_required
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

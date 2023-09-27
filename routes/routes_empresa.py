from flask import Blueprint, jsonify, render_template, request, redirect, url_for, flash
from models.empresa import Empresa
from utils.Logger import Logger
from flask_login import login_required

# objeto del controlador usuario
empresa = Empresa()

empresas = Blueprint('empresas', __name__, template_folder='templates')

@empresas.route('/empresas')
@login_required
def getEmpresas():
    row = empresa.get_empresas()
    if row !=None:
        return jsonify({"empresas": row})
    else:
        return jsonify({"mensaje": "No existe empresas"})
    

@empresas.route('/show_companies')
@login_required
def mostrar_empresas():
     return render_template('empresas.html')

# Ruta para obtener una empresa
# ----------------------------
@empresas.route('/empresa/<string:id_empresa>')
@login_required
def getEmpresa(id_empresa):
    row = empresa.get_empresa(id_empresa)
    if row!=None:
        return jsonify({"Empresa": row})
    else:
        return jsonify({"mensaje": "Empresa no existe"})
    
# Ruta para insetar nueva empresa
# -------------------------------
@empresas.route('/insert_empresa', methods=['POST'])
@login_required
def insertUsuario():
    if request.method == 'POST':
        var_empresa = request.json['empresa']
        try:
            response = empresa.insert_empresa(var_empresa)
            print(response)
            if response:
                Logger.add_to_log("info",f"Empresa agregado exitosamente -->{var_empresa}")
                return jsonify({"mensaje": "Empresa agregado exitosamente"})
            elif response == None:
                Logger.add_to_log("info","Empresa ya existe")
                return jsonify({"mensaje": "Empresa ya existe"})
        except Exception as e:
            return redirect(url_for('empresas.mostrar_empresas'))
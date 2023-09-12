from db.db_mysql import Mysql
from datetime import datetime 
import traceback
from utils.Logger import Logger

class Usuario:
    def __init__(self) :
        self.conexion = Mysql().conectar()
        self.id_empresa = ""
        self.header_user = []

    def getFecha(self):
        ahora = datetime.now()
        return str(ahora.date())

    def header_usuario(self):
        self.header_user = [
                "ID","USUARIO", "CLAVE", "FECHA REGISTRO", 
                "FECHA MODIFICACION", "ESTADO", "ID ROL", 
                "ID EMPRESA"
            ]
        return self.header_user


    def insert_usuario(self, usuario, password, id_rol):
        try:
            if self.existe_usuario(usuario) == None:
                with self.conexion.cursor() as cursor:
                    cursor.execute('''
                                INSERT INTO usuarios(
                                usuario, password, fecha_registro,
                                fecha_modificacion, estado, id_rol, id_empresa) 
                                VALUES (%s, %s, %s, %s, %s, %s, %s)''',
                                (usuario, password, self.getFecha(), self.getFecha(), '0', id_rol, self.id_empresa))
                self.conexion.commit()
                return True
            else:
                Logger.add_to_log("error", str('El usuario ya existe'))
                return False
        except Exception as err:
            print(err)
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


    def get_usuarios(self):
        try:
            usuarios = []
            with self.conexion.cursor() as cursor:
                cursor.execute('''SELECT id_usuario, usuario, f_registro, f_modificacion, 
                               id_rol, id_empresa, estado
                               FROM usuarios WHERE estado = %s AND id_empresa = %s''',
                               ('0',self.id_empresa))
                usuarios = cursor.fetchall()
            return usuarios
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
    

    def get_usuario(self, id_usuario):
        try:
            usuario = None
            with self.conexion.cursor() as cursor:
                cursor.execute(
                    '''SELECT * FROM usuarios WHERE id_usuario = %s
                    AND estado = %s AND id_empresa = %s''' , (id_usuario,'0', self.id_empresa))
                usuario = cursor.fetchone()
            return usuario
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


    def existe_usuario(self, _usuario):
        try:
            usuario = None
            with self.conexion.cursor() as cursor:
                cursor.execute(
                    '''SELECT * FROM usuarios WHERE usuario = %s 
                    AND estado = %s AND id_empresa = %s''' , 
                    (_usuario,'0',self.id_empresa))
                usuario = cursor.fetchone()
            return usuario
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


    def validar_usuario(self, _usuario, id_empresa, password):
        self.id_empresa = id_empresa
        try:
            usuario = None
            with self.conexion.cursor() as cursor:
                cursor.execute(
                    '''SELECT * FROM usuarios WHERE usuario = %s 
                    AND estado = %s AND id_empresa = %s AND password = %s''' , 
                    (_usuario,'0',id_empresa, password))
                cursor.description
                usuario = cursor.fetchone()
            return usuario
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())

    def update_usuario(self, usuario, password, id_rol, id_usuario):
        try:
            with self.conexion.cursor() as cursor:
                cursor.execute('''
                                UPDATE usuarios 
                                SET usuario = %s, password = %s, fecha_modificacion = %s, id_rol = %s
                                WHERE id_usuario = %s AND id_empresa = %s''',
                            (usuario, password, self.getFecha(), id_rol, id_usuario, self.id_empresa))
            self.conexion.commit()

        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


    def delete_usuario(self,id_usuario, estado):
        try:
            with self.conexion.cursor() as cursor:
                cursor.execute('''
                                UPDATE usuarios 
                                SET estado = %s, fecha_modificacion = %s
                                WHERE id_usuario = %s AND id_empresa = %s''',
                            (estado, self.getFecha(), id_usuario, self.id_empresa))
            self.conexion.commit()
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


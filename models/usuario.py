from db import mysql
from datetime import datetime 
import traceback
from utils.Logger import Logger

class Usuario:
    def __init__(self) :
        self.id_empresa = ""
        self.header_user = []

    def getFecha(self):
        ahora = datetime.now()
        return str(ahora.date())


    def insert_usuario(self, usuario, password, id_rol):
        try:
            if self.existe_usuario(usuario) == None:
                with mysql.connection.cursor() as cursor:
                    cursor.execute('''
                                INSERT INTO usuarios(
                                usuario, password, f_registro,
                                f_modificacion, estado, id_rol, id_empresa) 
                                VALUES (%s, %s, %s, %s, %s, %s, %s)''',
                                (usuario, password, self.getFecha(), self.getFecha(), '0', id_rol, self.id_empresa))
                mysql.connection.commit()
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
            with mysql.connection.cursor() as cursor:
                cursor.execute('''
                               
                               SELECT us.id_usuario, us.usuario, us.password, us.f_registro, 
                               us.f_modificacion, rol.nombre_rol, em.nombre_empresa, us.estado
                               FROM usuarios as us 
                               inner join empresas as em 
                               on us.id_empresa = em.id_empresa  
                               inner join roles as rol 
                               on us.id_rol = rol.id_rol
                               WHERE us.estado = %s AND us.id_empresa = %s
                               order by us.id_usuario desc''',
                               ('0',self.id_empresa))
                usuarios = cursor.fetchall()
            return usuarios
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
    

    def get_usuario(self, id_usuario):
        try:
            usuario = None
            with mysql.connection.cursor() as cursor:
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
            with mysql.connection.cursor() as cursor:
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
            with mysql.connection.cursor() as cursor:
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
            with mysql.connection.cursor() as cursor:
                cursor.execute('''
                                UPDATE usuarios 
                                SET usuario = %s, password = %s, f_modificacion = %s, id_rol = %s
                                WHERE id_usuario = %s AND id_empresa = %s''',
                            (usuario, password, self.getFecha(), id_rol, id_usuario, self.id_empresa))
            mysql.connection.commit()
            return True
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
            return False


    def delete_usuario(self,id_usuario, estado):
        try:
            with mysql.connection.cursor() as cursor:
                cursor.execute('''
                                UPDATE usuarios 
                                SET estado = %s, f_modificacion = %s
                                WHERE id_usuario = %s AND id_empresa = %s''',
                            (estado, self.getFecha(), id_usuario, self.id_empresa))
            mysql.connection.commit()
            return True
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
            return False

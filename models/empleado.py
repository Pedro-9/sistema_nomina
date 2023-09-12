from db.db_mysql import Mysql
from datetime import datetime 
import traceback
from utils.Logger import Logger

class Empleado():
    def __init__(self) :
        self.conexion = Mysql().conectar()

    def getFecha(self):
        ahora = datetime.now()
        return str(ahora.date())

    def insert_usuario(self, usuario, password, id_rol, id_empresa):
        try:
            if self.existe_usuario(usuario, id_empresa):
                with self.conexion.cursor() as cursor:
                    cursor.execute('''
                                INSERT INTO usuarios(
                                usuario, password, fecha_registro,
                                fecha_modificacion, estado, id_rol) 
                                VALUES (%s, %s, %s, %s, %s, %s)''',
                                (usuario, password, self.getFecha(), self.getFecha(), '0', id_rol))
                self.conexion.commit()
                return True
            else:
                Logger.add_to_log("error", str('El usuario ya existe'))
                return False
        except Exception as err:
            print(err)
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


    def get_empleados(self):
        try:
            usuarios = []
            with self.conexion.cursor() as cursor:
                cursor.execute("SELECT * FROM empleados WHERE estado = %s",('0'))
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
                    "SELECT * FROM usuarios WHERE id_usuario = %s AND estado = %s" , (id_usuario,'0'))
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
                    "SELECT * FROM usuarios WHERE usuario = %s AND estado = %s" , (_usuario,'0'))
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
                                WHERE id_usuario = %s''',
                            (usuario, password, self.getFecha(), id_rol, id_usuario))
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
                                WHERE id_usuario = %s''',
                            (estado, self.getFecha(), id_usuario))
            self.conexion.commit()
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())

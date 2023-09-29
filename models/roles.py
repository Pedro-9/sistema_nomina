from db import mysql
from datetime import datetime
import traceback
from utils.Logger import Logger


class Rol:
    def __init__(self):
        self.id_empresa = ""

    def getFecha(self):
        ahora = datetime.now()
        return str(ahora.date())

    @staticmethod
    def execute_query(query, params=None, fetchall=False):
        try:
            with mysql.connection.cursor() as cursor:
                cursor.execute(query, params)
                if fetchall:
                    return cursor.fetchall()
                else:
                    return cursor.fetchone()
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
            return None

    def get_roles(self):
        query = 'SELECT * FROM roles where estado = %s'
        params = ('0')
        return self.execute_query(query, params=params, fetchall=True)

    def get_rol(self, id_rol):
        query = 'SELECT * FROM roles where estado = %s AND id_rol = %s'
        params = ('0', id_rol)
        return self.execute_query(query, params=params)

from db import mysql
from datetime import datetime 
import traceback
from utils.Logger import Logger

class Rol:
    def __init__(self) :
        self.id_empresa = ""

    def getFecha(self):
        ahora = datetime.now()
        return str(ahora.date())
    
    def get_roles(self):
        try:
            roles = []
            with mysql.connection.cursor() as cursor:
                cursor.execute('SELECT * FROM roles')
                roles = cursor.fetchall()
            return roles
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())
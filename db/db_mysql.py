import pymysql
from dotenv import load_dotenv
import os
import traceback
from utils.Logger import Logger

load_dotenv()  # take environment variables from .env.

class Mysql:
    def __init__(self) :
        self.user = os.getenv('MYSQL_USER') 
        self.password = os.getenv('MYSQL_PASSWORD') 
        self.host = os.getenv('MYSQL_HOST') 
        self.db = os.getenv('MYSQL_DB') 
        self.conexion = ''


    def conectar(self):
        try:
            self.conexion = pymysql.connect(host=self.host,
                                    user=self.user,
                                    password=self.password,
                                    db=self.db)
            return self.conexion
        except Exception as err:
            Logger.add_to_log("error", str(err))
            Logger.add_to_log("error", traceback.format_exc())


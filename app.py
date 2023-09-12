from flask import Flask
from routes.routes_usuario import usuario


app = Flask(__name__)
app.secret_key = "mysecretkey"

app.register_blueprint(usuario)

if __name__ == '__main__':
    app.run(port=3000, debug=True)
    
from my_app import app
from routes.routes_usuario import usuario
from routes.routes_roles import roles

app.register_blueprint(usuario)
app.register_blueprint(roles)

if __name__ == '__main__':
    app.run(port=3000, debug=True)
    
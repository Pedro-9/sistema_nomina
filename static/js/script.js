let pagina = 1;
let pagina_empresa = 1;
const registrosPorPagina = 10;
const row_empresa = 10;

// Eventos botones para tabla dinamica usuarios
// --------------------------------------------

function mostrarMasUsuarios(){
    pagina++;
    get_usuarios();
}

function regresarUsuarios(){
    if (pagina > 1) {
        pagina--;
        get_usuarios();
    }
}

// --------------------------------------------------------
// Funcion para obtener la lista de todos los usuarios
// --------------------------------------------------------
function get_usuarios() {
    fetch('/usuarios', { method: 'GET' })
        .then(response => response.json())
        .then(data => mostrarDataUsuario(data))
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para mostrar datos de usuarios en tabla html
// --------------------------------------------------------
function mostrarDataUsuario(data) {
    //console.log(data)
    data = data.usuarios
    let body = ""
    const inicio = (pagina - 1) * registrosPorPagina;
    const fin = pagina * registrosPorPagina;
    for (let i = inicio; i < fin; i++) {
        if (i < data.length) {
            if(data[i].estado === 0){
                data[i].estado = '<span class="badge badge-success">Activo</span>'
            }
            body += `<tr><td>${data[i].id_usuario}</td><td>${data[i].usuario}</td>
                            <td>${data[i].f_registro}</td><td>${data[i].f_modificacion}</td><td>${data[i].nombre_rol}</td>
                            <td>${data[i].id_empresa}</td><td>${data[i].nombre_empresa}</td><td>${data[i].estado}</td><td>
                            <button onclick="editar_usuario(${data[i].id_usuario}, ${data[i].id_empresa}, ${data[i].id_rol})"class="btn btn-success">Editar</button>
                            <button onclick="eliminar_usuario(${data[i].id_usuario})" class="btn btn-danger">Eliminar</button></td></tr>`
        }
    }
    document.getElementById('data').innerHTML = body;
}


// --------------------------------------------------------
// Funcion para mostrar lista de roles
// --------------------------------------------------------
function get_roles(tipo_select, defaultRolId = null) {
    const type = tipo_select
    fetch('/roles', { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            const select = document.getElementById(type);
            select.innerHTML = ''; // Eliminar el mensaje de "Cargando roles..."
            //console.log(data)
            data = data.roles
            data.forEach(rol => {
                const option = document.createElement('option');
                option.value = rol.id_rol; // Asigna el valor que desees
                option.textContent = rol.nombre_rol; // Asigna el texto que desees
                // Establece el valor seleccionado si coincide con el valor por defecto proporcionado
                if (defaultRolId && rol.id_rol === defaultRolId) {
                    option.selected = true;
                }
                select.appendChild(option);
            });
        })
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para agregar usuarios por medio de servicio
// --------------------------------------------------------
function add_usuario() {
    const _usuario = document.getElementById('usuario').value;
    const _password = document.getElementById('password').value;
    const _rol = document.getElementById('selectRoles').value;
    const _empresa = document.getElementById('selectEmpresa').value;

    if (!_usuario || !_password || !_rol) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { usuario: _usuario, password: _password, rol: _rol, empresa: _empresa }

    // Header por default
    const _header = { "Content-Type": "application/json" }

    fetch('/insert_usuario', {
        method: "POST",
        body: JSON.stringify(_body),
        headers: _header
    })
        .then((res) => res.json())
        .then((response) => {
            alert(response.mensaje);
            //console.log(response);
            resetForm('isertar_usuario'); // id de formulario como parametro
            location.reload(true);
        })
        .catch((error) => console.error("Error", error))
}

// --------------------------------------------------------
// Funcion para resetear un formulario especifico
// --------------------------------------------------------
function resetForm(formulario) {
    // Obtén el formulario por su ID o de alguna otra manera
    const form = document.getElementById(formulario);

    // Restablece el formulario
    form.reset();
}


// --------------------------------------------------------
// Funcion para rellenar el formulario de editar usuario
// --------------------------------------------------------
function editar_usuario(id_usuario, id_empresa, id_rol) {
    fetch('/usuarios/' + id_usuario, { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            data = data.Usuario;
            document.getElementById("id_usuario").value = data.id_usuario;
            document.getElementById("editUsuario").value = data.usuario;
            document.getElementById("editPassword").value = data.password;
            get_roles('selectEditRoles', id_rol);
            get_select_empresas('selectEditEmpresa', id_empresa);
            $('#modal_editar').modal('show');
        })
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para actualizar un usuario
// --------------------------------------------------------
function actualizar_usuario() {
    const _id = document.getElementById('id_usuario').value;
    const _usuario = document.getElementById('editUsuario').value;
    const _password = document.getElementById('editPassword').value;
    const _rol = document.getElementById('selectEditRoles').value;
    const _empresa = document.getElementById('selectEditEmpresa').value;

    if (!_id || !_usuario || !_password || !_rol || !_empresa) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { usuario: _usuario, password: _password, rol: _rol, id: _id, empresa: _empresa }
    //console.log(_body)
    // Header por default
    const _header = { "Content-Type": "application/json" }

    fetch('/update_usuario', {
        method: "POST",
        body: JSON.stringify(_body),
        headers: _header
    })
        .then((res) => res.json())
        .then((response) => {
            alert(response.mensaje);
            //console.log(response);
            resetForm('actualizar_usuario'); // id de formulario como parametro
            location.reload(true);
        })
        .catch((error) => console.error("Error", error))
}

// --------------------------------------------------------
// Funcion para eliminar un usuario
// --------------------------------------------------------
function eliminar_usuario(id_usuario) {
    if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
        // Enviar solicitud para eliminar el registro
        fetch('/delete_usuario/' + id_usuario)
            .then(res => res.json())
            .then(response => {
                alert(response.mensaje);
                //console.log(response);
                location.reload(true);
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
}


// Eventos botones para tabla dinamica empresa
// --------------------------------------------
function mostrarMasEmpresa(){
    pagina_empresa++;
    get_empresas();
}

function regresarEmpresa() {
    if (pagina_empresa > 1) {
        pagina_empresa--;
        get_empresas();
    }
}



// --------------------------------------------------------
// Funcion para obtener la lista de todas las empresas
// --------------------------------------------------------
function get_empresas() {
    fetch('/empresas', { method: 'GET' })
        .then(response => response.json())
        .then(data => mostrarDataEmpresas(data))
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para mostrar datos de empresas en tabla html
// --------------------------------------------------------
function mostrarDataEmpresas(data) {
    //console.log(data)
    data = data.empresas
    let body = ""
    const inicio = (pagina_empresa - 1) * row_empresa;
    const fin = pagina_empresa * row_empresa;
    for (let i = inicio; i < fin; i++) {
        if (i < data.length) {
            if (data[i].estado === 0){
                data[i].estado = '<span class="badge badge-success">Activo</span>'
            }

            body += `<tr><td>${data[i].id_empresa}</td><td>${data[i].nombre_empresa}</td>
                            <td>${data[i].fecha_ingreso}</td><td>${data[i].estado}</td>
                            <td>
                            <button onclick="editar_empresa(${data[i].id_empresa})" class="btn btn-success">Editar</button>
                            <button onclick="eliminar_empresa(${data[i].id_empresa})" class="btn btn-danger">Eliminar</button></td></tr>`
        }
    }
    document.getElementById('data_empresa').innerHTML = body;
}

// --------------------------------------------------------
// Funcion para rellenar el formulario de editar empresa
// --------------------------------------------------------
function editar_empresa(id_empresa) {
    fetch('/empresa/' + id_empresa, { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            data = data.Empresa;
            //console.log(data)
            document.getElementById("id_empresa").value = data.id_empresa;
            document.getElementById("editEmpresa").value = data.nombre_empresa;
            $('#modal_editar_empresa').modal('show');
        })
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para agregar empresa por medio de servicio
// --------------------------------------------------------
function add_empresa() {
    const _empresa = document.getElementById('nombre_empresa').value;


    if (!_empresa) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { empresa: _empresa }

    // Header por default
    const _header = { "Content-Type": "application/json" }

    fetch('/insert_empresa', {
        method: "POST",
        body: JSON.stringify(_body),
        headers: _header
    })
        .then((res) => res.json())
        .then((response) => {
            alert(response.mensaje);
            //console.log(response);
            resetForm('isertar_empresa'); // id de formulario como parametro
            location.reload(true);
        })
        .catch((error) => console.error("Error", error))
}

// --------------------------------------------------------
// Funcion para mostrar lista de roles
// --------------------------------------------------------
function get_select_empresas(tipo_select, defaultIdEmpresa = null) {
    const type = tipo_select
    fetch('/empresas', { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            const select = document.getElementById(type);
            select.innerHTML = ''; // Eliminar el mensaje de "Cargando roles..."
            //console.log(data)
            data = data.empresas
            data.forEach(empresa => {
                const option = document.createElement('option');
                option.value = empresa.id_empresa; // Asigna el valor que desees
                option.textContent = empresa.nombre_empresa; // Asigna el texto que desees

                // Establece el valor seleccionado si coincide con el valor por defecto proporcionado
                if (defaultIdEmpresa && empresa.id_empresa === defaultIdEmpresa) {
                    option.selected = true;
                }

                select.appendChild(option);
            });
        })
        .catch(error => console.log(error))
}


// --------------------------------------------------------
// Funcion para actualizar una empresa
// --------------------------------------------------------
function actualizar_empresa() {
    const _id = document.getElementById('id_empresa').value;
    const _empresa = document.getElementById('editEmpresa').value;


    if (!_id || !_empresa) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { id: _id, empresa: _empresa}
    //console.log(_body)
    // Header por default
    const _header = { "Content-Type": "application/json" }

    fetch('/update_empresa', {
        method: "POST",
        body: JSON.stringify(_body),
        headers: _header
    })
        .then((res) => res.json())
        .then((response) => {
            alert(response.mensaje);
            //console.log(response);
            resetForm('actualizar_empresa'); // id de formulario como parametro
            location.reload(true);
        })
        .catch((error) => console.error("Error", error))
}


// --------------------------------------------------------
// Funcion para eliminar una empresa
// --------------------------------------------------------
function eliminar_empresa(id_empresa) {
    if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
        // Enviar solicitud para eliminar el registro
        fetch('/delete_empresa/'+ id_empresa)
            .then(res => res.json())
            .then(response => {
                alert(response.mensaje);
                //console.log(response);
                location.reload(true);
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
}
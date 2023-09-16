

let pagina = 1;
const registrosPorPagina = 10;
const mostrarMasBtn = document.getElementById('mostrarMas');
const regresarBtn = document.getElementById('regresar');

mostrarMasBtn.addEventListener('click', () => {
    pagina++;
    get_usuarios();
});

regresarBtn.addEventListener('click', () => {
    if (pagina > 1) {
        pagina--;
        get_usuarios();
    }
});

// --------------------------------------------------------
// Funcion para obtener la lista de todos los usuarios
// --------------------------------------------------------
function get_usuarios() {
    fetch('/usuarios', { method: 'GET' })
        .then(response => response.json())
        .then(data => mostrarData(data))
        .catch(error => console.log(error))
}

// --------------------------------------------------------
// Funcion para mostrar datos de usuarios en tabla html
// --------------------------------------------------------
function mostrarData(data) {
    console.log(data)
    var data = data.usuarios
    let body = ""
    const inicio = (pagina - 1) * registrosPorPagina;
    const fin = pagina * registrosPorPagina;
    for (let i = inicio; i < fin; i++) {
        if (i < data.length) {
            body += `<tr><td>${data[i].id_usuario}</td><td>${data[i].usuario}</td><td>${data[i].password}</td>
                            <td>${data[i].f_registro}</td><td>${data[i].f_modificacion}</td><td>${data[i].nombre_rol}</td>
                            <td>${data[i].nombre_empresa}</td><td>${data[i].estado}</td><td>
                            <button onclick="editar_usuario(${data[i].id_usuario})" class="btn btn-success">Editar</button>
                            <button onclick="eliminar_usuario(${data[i].id_usuario})" class="btn btn-danger">Eliminar</button></tr>`
        }
    }
    document.getElementById('data').innerHTML = body;
}


// filtro de datos 
const searchInput = document.getElementById("searchInput");
const resultsList = document.getElementById("results");

// Función para filtrar elementos según la entrada de búsqueda
function filterElements(searchTerm) {
    // Limpia la lista de resultados
    resultsList.innerHTML = "";

    // Filtra los elementos que coinciden con el término de búsqueda
    const filteredElements = data.filter(element =>
        element.usuario.toLowerCase().includes(searchTerm.toLowerCase())
    );

    // Crea y muestra los elementos coincidentes
    filteredElements.forEach(element => {
        const listItem = document.createElement("li");
        listItem.textContent = element.usuario;
        resultsList.appendChild(listItem);
    });
}

// Evento de entrada en el campo de búsqueda
searchInput.addEventListener("input", function () {
    const searchTerm = searchInput.value;
    filterElements(searchTerm);
});

// --------------------------------------------------------
// Funcion para mostrar lista de roles
// --------------------------------------------------------
function get_roles(tipo_select) {
    const type = tipo_select
    fetch('/roles', { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            const select = document.getElementById(type);
            select.innerHTML = ''; // Eliminar el mensaje de "Cargando roles..."
            console.log(data)
            data = data.roles
            data.forEach(rol => {
                const option = document.createElement('option');
                option.value = rol.id_rol; // Asigna el valor que desees
                option.textContent = rol.nombre_rol; // Asigna el texto que desees
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

    if (!_usuario || !_password || !_rol) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { usuario: _usuario, password: _password, rol: _rol }

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
            console.log(response);
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
function editar_usuario(id_usuario) {
    fetch('/usuarios/' + id_usuario, { method: 'GET' })
        .then(response => response.json())
        .then(data => {
            data = data.Usuario;
            document.getElementById("id_usuario").value = data.id_usuario;
            document.getElementById("editUsuario").value = data.usuario;
            document.getElementById("editPassword").value = data.password;
            get_roles('selectEditRoles');
            $('#modal_editar').modal('show');
        })
        .catch(error => console.log(error))
}

function actualizar_usuario() {
    const _id = document.getElementById('id_usuario').value;
    const _usuario = document.getElementById('editUsuario').value;
    const _password = document.getElementById('editPassword').value;
    const _rol = document.getElementById('selectEditRoles').value;

    if (!_id || !_usuario || !_password || !_rol) {
        alert("Por favor, complete todos los campos.");
        return;
    }

    // armar el body 
    const _body = { usuario: _usuario, password: _password, rol: _rol, id: _id }
    console.log(_body)
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
            console.log(response);
            resetForm('actualizar_usuario'); // id de formulario como parametro
            location.reload(true);
        })
        .catch((error) => console.error("Error", error))
}

function eliminar_usuario(id_usuario) {
    if (confirm("¿Estás seguro de que deseas eliminar este registro?")) {
        // Enviar solicitud para eliminar el registro
        fetch('/delete_usuario/' + id_usuario)
            .then(res => res.json())
            .then(response => {
                alert(response.mensaje);
                console.log(response);
                location.reload(true);
            })
            .catch(error => {
                console.error("Error:", error);
            });
    }
}
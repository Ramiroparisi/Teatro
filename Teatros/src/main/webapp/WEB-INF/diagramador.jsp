<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.teatro.modelo.Asiento, com.teatro.modelo.Teatro, java.util.List" %>
<%
    Teatro teatro = (Teatro) request.getAttribute("teatro");
    List<Asiento> existentes = (List<Asiento>) request.getAttribute("asientos");
    int capacidad = (teatro != null) ? teatro.getCapacidad() : 100;
    int dimension = (int) Math.ceil(Math.sqrt(capacidad));
    if (dimension < 10) dimension = 10;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Diagramador - <%= teatro.getNombre() %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <style>
        body { background-color: #f4f7f6; }
        .grid-container { 
            display: grid; 
            grid-template-columns: 45px repeat(<%= dimension %>, 35px); 
            gap: 5px; background: white; padding: 20px; border-radius: 10px;
            width: fit-content; margin: 20px auto;
        }
        .cell { 
            width: 35px; height: 35px; background: #dfe6e9; 
            border-radius: 4px; cursor: pointer; display: flex;
            align-items: center; justify-content: center; transition: 0.1s;
        }
        /* Clase forzada para asegurar que se vea verde */
        .asiento { background-color: #27ae60 !important; color: white !important; }
        .asiento::after { content: '\f4b0'; font-family: "Font Awesome 5 Free"; font-weight: 900; font-size: 12px; }
        
        .ctrl-row { background: #3498db; color: white; cursor: pointer; text-align: center; line-height: 35px; border-radius: 4px; font-weight: bold; }
        .ctrl-col { background: #9b59b6; color: white; cursor: pointer; text-align: center; border-radius: 4px; font-weight: bold; height: 35px; line-height: 35px; }
        .escenario { width: 100%; max-width: 500px; height: 30px; background: #34495e; color: white; margin: 10px auto; text-align: center; line-height: 30px; border-radius: 5px; font-weight: bold; }
    </style>
</head>
<body>

<div class="container py-4 text-center">
    <h2><%= teatro.getNombre() %></h2>
    <div class="escenario">ESCENARIO</div>

    <form action="diagramarTeatro" method="POST" id="formDiagrama">
        <input type="hidden" name="teatroId" value="<%= teatro.getId() %>">
        
        <div class="grid-container" id="grid">
            <div></div>
            <% for(int c=1; c<=dimension; c++) { %>
                <div class="ctrl-col" onclick="toggleCol(<%= c %>)"><%= c %></div>
            <% } %>

            <% for(int f=1; f<=dimension; f++) { %>
                <div class="ctrl-row" onclick="toggleRow(<%= f %>)"><%= (char)(64+f) %></div>
                <% for(int c=1; c<=dimension; c++) { %>
                    <div class="cell" 
                         data-f="<%= f %>" 
                         data-c="<%= c %>" 
                         onclick="this.classList.toggle('asiento'); actualizarContador();">
                    </div>
                <% } %>
            <% } %>
        </div>

        <div id="inputsOcultos"></div>

        <div class="mt-4">
            <p class="h5">Asientos: <span id="contador">0</span> / <%= capacidad %></p>
            <button type="button" onclick="enviar()" class="btn btn-success btn-lg px-5 shadow">Guardar Cambios</button>
            <button type="button" onclick="limpiarTodo()" class="btn btn-outline-danger btn-lg ms-2">Limpiar Todo</button>
        </div>
    </form>
</div>



<script>
    // 1. Cargar asientos existentes al cargar la página
    document.addEventListener("DOMContentLoaded", () => {
        <% if(existentes != null) { 
            for(Asiento a : existentes) { %>
            const el = document.querySelector('.cell[data-f="<%= a.getFilaCoord() %>"][data-c="<%= a.getColCoord() %>"]');
            if(el) el.classList.add('asiento');
        <% } } %>
        actualizarContador();
    });

    // 2. Función para seleccionar FILA entera (Busca por data-f)
    function toggleRow(f) {
        // Seleccionamos todas las celdas que tengan el atributo data-f igual al número de fila
        const celdas = document.querySelectorAll(`.cell[data-f="${f}"]`);
        
        // Verificamos si hay alguna celda vacía en esa fila
        let hayVacias = false;
        celdas.forEach(c => { if(!c.classList.contains('asiento')) hayVacias = true; });

        // Si hay vacías, llenamos todas. Si no hay vacías, vaciamos todas.
        celdas.forEach(c => {
            if(hayVacias) c.classList.add('asiento');
            else c.classList.remove('asiento');
        });
        actualizarContador();
    }

    // 3. Función para seleccionar COLUMNA entera (Busca por data-c)
    function toggleCol(c) {
        const celdas = document.querySelectorAll(`.cell[data-c="${c}"]`);
        
        let hayVacias = false;
        celdas.forEach(celda => { if(!celda.classList.contains('asiento')) hayVacias = true; });

        celdas.forEach(celda => {
            if(hayVacias) celda.classList.add('asiento');
            else celda.classList.remove('asiento');
        });
        actualizarContador();
    }

    function actualizarContador() {
        const cant = document.querySelectorAll('.cell.asiento').length;
        document.getElementById('contador').innerText = cant;
    }

    function limpiarTodo() {
        if(confirm("¿Borrar todo el diseño?")) {
            document.querySelectorAll('.cell.asiento').forEach(c => c.classList.remove('asiento'));
            actualizarContador();
        }
    }

    function enviar() {
        const seleccionados = document.querySelectorAll('.cell.asiento');
        const container = document.getElementById('inputsOcultos');
        container.innerHTML = '';

        if(seleccionados.length > <%= capacidad %>) {
            alert("Has superado la capacidad permitida."); return;
        }

        seleccionados.forEach(el => {
            const f = el.getAttribute('data-f');
            const c = el.getAttribute('data-c');
            const letra = String.fromCharCode(64 + parseInt(f));
            
            container.innerHTML += `<input type="hidden" name="filaCoord[]" value="${f}">`;
            container.innerHTML += `<input type="hidden" name="colCoord[]" value="${c}">`;
            container.innerHTML += `<input type="hidden" name="nombreFila[]" value="${letra}">`;
            container.innerHTML += `<input type="hidden" name="numeroAsiento[]" value="${c}">`;
        });
        document.getElementById('formDiagrama').submit();
    }
</script>
</body>
</html>
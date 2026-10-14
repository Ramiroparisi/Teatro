<div align="center">
<img width="300" height="300" alt="utn" src="https://github.com/user-attachments/assets/5d14773d-ef97-48f9-a083-8956746cbce3" />

# Universidad Tecnológica Nacional
## Facultad Regional Rosario
### Ingeniería en Sistemas de Información

**Lenguaje de programación JAVA**  
**Trabajo Práctico Integrador**  
**Comisión 3EK04 - Etapa Final**

**Profesores:**
Ing. Adrián Meca | Ing. Bruno Mollo | Ing. Ricardo Tabacman

</div>

---

### Datos del Alumno

| Alumno | Mail | Legajo |
| :--- | :--- | :--- |
| Parisi, Ramiro Daniel | ramiroparisi678@gmail.com | 51035 |

**Fecha de entrega:** 19/08/2026

---

# Documentación del Sistema: Teatros de Rosario (Trabajo Final)

## Modelo de Datos (DER)
Se detalla el esquema basado en el Diagrama Entidad-Relación (DER) del proyecto:

### Entidades y Atributos Principales

* **Usuario:**
  * **Atributos:** ID (PK), nombre, apellido, tipo Doc, documento, telefono, mail, contrasena, rol.
  * **Clave foránea opcional:** TeatroID (FK) -> Solo si el rol es Empleado.
* **Teatro:**
  * **Atributos:** ID (PK), nombre, dirección, ciudad, país, capacidad.
* **Obra:**
  * **Atributos:** ID (PK), Nombre, foto, descripcion, duracion.
  * **Claves Foráneas:** empleadoID (FK, Creador), teatroID (FK).
* **Función:**
  * **Atributos:** ID (PK), fecha, hora, precio.
  * **Claves Foráneas:** ObraID (FK).
* **Asiento:**
  * **Atributos:** ID (PK), Numero, filaCoord, colCoord, filaNombre.
  * **Clave Foránea:** TeatroID (FK).
* **Entrada:**
  * **Atributos:** ID (PK), Estado.
  * **Claves Foráneas:** ClienteID (FK), FunciónID (FK), AsientoID (FK).
* **Pedido:**
  * **Atributos:** ID (PK), fecha, total, estado, metodo Pago, mercado PagoID.
  * **Clave Foránea:** UsuarioID (FK).
* **Detalle Venta:**
  * **Atributos:** ID (PK), precioUnitario.
  * **Claves Foráneas:** pedidoID (FK), entradaID (FK).

### Relaciones Clave (N:M y 1:N)
* Un Usuario (Cliente) puede tener N Pedidos. **(1:N)**
* Un Teatro aloja N Obras y tiene N Asientos. **(1:N)**
* Una Obra tiene N Funciones. **(1:N)**
* Un Pedido incluye N DetalleVenta. **(1:N)**
* Una Entrada está asociada a 1 Asiento y 1 Función.

**Diagrama DER:**  
Se adjunta el diagrama para facilitar la comprensión:  
[Ver diagrama en draw.io ](https://drive.google.com/file/d/1GOj1frXQ_f--uAOp4revz33eggTfYStH/view?usp=sharing)

---

## Checklist del Alcance del Sistema
Se verifica el cumplimiento de las funcionalidades desarrolladas frente a los requisitos del trabajo final.

| Requisito / Funcionalidad | Observaciones / Artefacto Relacionado |
| :--- | :--- |
| **Arquitectura** | |
| Orientación a Objetos en Java | En `com.teatro.modelo` se puede ver la relación entre las entidades. |
| Cliente-Servidor Web | Servlets respondiendo a peticiones HTTP. |
| Uso de JSP / Servlets | Vistas en `.jsp` (ej. `index.jsp`) y controladores en `Servlet.java`. |
| Arquitectura en Capas | Modelo (`/modelo`), Vista (`/webapp`), Controlador (`/controlador`), Acceso a Datos (`/data`). |
| **Base de Datos** | |
| Conexión y Clases DAO | Manipulación (CRUD). |
| Uso de Prepared Statements | Implementado en los DAOs para prevenir inyecciones SQL. |
| **Gestión de Usuarios y Seguridad** | |
| Manejo de niveles de usuario | **Roles definidos:**<br><ul><li>**Cliente:** Solo puede observar el catálogo y comprar entradas.</li><li>**Empleado:** Un empleado le pertenece a 1 teatro, solo puede agregar y modificar obras y funciones en el teatro que le corresponde. (No desarrollado)</li><li>**Admin:** Puede manipular todo, comenzando por los usuarios, teatros, obras, funciones.</li></ul> |
| Validación de sesión (Servidor) | Uso de `HttpSession` para restringir accesos esto se puede ver en `UsuarioServlet` y `AdminDashboardServlet`. |
| **Funcionalidades Core (ABMC)** | |
| ABMC de Obras | Alta, Baja, Modif. y Consulta. |
| ABMC de Teatros | Alta y listado de teatros. |
| **Gestión de Funciones** | |
| Asignación de funciones a obras | *(Asignado correctamente)* |
| Proceso de Venta / Carrito | Selección de asientos y confirmación de compra. |
| **Manejo de Errores y Validaciones**| |
| Manejo de Errores en Ejecución | Bloques `try-catch` (ej. `SQLException` en `RegistroServlet`). |
| Validaciones (Cliente) | Uso de el atributo `required` de HTML5 en algunas ocasiones. |

---

## Video con demo del sistema
En el siguiente link se puede ver una demo en la que se puede ver todo el alcance del sistema:
[Demo en youtube:](https://www.youtube.com/)

## Código fuente
Aquí se puede encontrar el código fuente del proyecto:  
[Repositorio en GitHub: Ramiroparisi/Teatro](https://github.com/Ramiroparisi/Teatro)

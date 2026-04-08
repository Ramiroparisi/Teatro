## Teatros de Rosario

### Integrante
* 51035 - Parisi Ramiro

### Enunciado general
Sistema de venta de entradas para todos los teatros de la ciudad que estén registrados, el mismo cuenta con listado de las obras y funciones filtrados por fecha y/o teatro, selección de butacas y proceso de pagos con Mercado Pago. Contempla 4 roles diferentes: Invitado, Cliente, Empleado y Administrador.

La cuenta de empleado permite ABMC de obras y funciones del teatro en el que trabaja, también puede modificar sus propios datos. Un usuario con rol de administrador puede hacer ABMC de teatros, clientes, empleados, obras y funciones.

![Teatro](https://github.com/user-attachments/assets/5640978f-8045-45c5-b19f-b0efe30d5855)



##### Regularidad

Requerimiento|Detalle/Listado de casos incluidos
|:-|:-|
|ABMC simple|Usuario <br> Teatro|
|ABMC dependiente|Obra|
|CU NO-ABMC|Login y registro de usuario|
|Listado simple|Clientes y empleados|

##### Aprobación Directa

Requerimiento|Detalle/Listado de casos incluidos
|:-|:-|
|ABMC|Funcion <br> Entrada <br> Asiento <br> DetalleVenta <br> Pedido|
|CU "Complejo"(nivel resumen)|Venta de entradas|
|Listado complejo|Obras y funciones filtrados por fecha y/o teatro|
|Niveles de acceso|4 (Invitado, Cliente, Empleado y Administrador)|

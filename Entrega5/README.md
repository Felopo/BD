# Entrega 5 - README

## Deploy de la Web API

La url de la API es proyectobdd-99.herokuapp.com.

Los archivos de nuestra API desarrollada en la entrega número 4 se encuentran en la carpeta `Entrega5`, donde utilizamos otro repositorio para hacer el deploy a Heroku. Además de lo implementado en la entrega anterior agregamos dos rutas nuevas para ayudarnos en las tareas de esta entrega:

1. Para poder obtener el id del usuario en mongo, dado el id de usuario en postgres, creamos la ruta GET `mongoid/:nombre`, donde al entregar el nombre de usuario la API nos entrega el id en mongo correspondiente. Este id queda guardado durante la sesión, por lo que solo se pide una vez. Acá asumimos que no habrán dos usuarios con el mismo nombre.

2. Dado que los usuarios nuevos también pueden enviar mensajes, creamos la ruta POST `/user`, la cual crea en la base de datos de mongo el nuevo usuario, siempre y cuando este se haya creado correctamente en postgres.

## Funcionalidades básicas

Lo pedido en esta parte se encuentra en la sección `Mensajes` de la barra de navegación. Dentro de esta sección están las cuatro opciones: Enviar mensaje, Mensajes enviados, Mensajes recibidos y Buscar mensajes, correspondiente a las cuatro funcionalidades pedidas.

### Consideraciones

1. Las coordenadas dadas para el envío de mensajes fueron cargadas en la base de datos postgres de la entrega3, en particular en la tabla `Coordenadas_Puertos`. En caso de mensajes nuevos se utiliza esta tabla para el caso de jefes de instalación, y lo indicado en las issues para los capitanes y nuevos usuarios.

2. Para enviar un mensaje a otro usuario, se debe utilizar el nombre y no el id, ya que creemos que esto es más realista

3. Los términos a buscar en cada caso se deben separar por una coma. La `Búsqueda simple` corresponde a el parámetro desired, `Búsqueda exacta` a required y `No buscar` al forbidden.

4. Usamos latitud -33.4562406 y longitud -70.6517248 como coordenadas de Santiago para el envío de mensajes de usuarios nuevos.


### Ideas de corrección

Creamos un usuario aparte de los capitanes y jefes de instalación llamado `Felipe Moya` al cual se le pueden enviar mensajes para probar esta parte, aunque obviamente se puede probar con cualquiera. Sus credenciales son `20121218-9` y contraseña `1111111` por si quizás también se quiere probar el envío de mensajes con este usuario.

Para ver mensajes enviados, recibidos y la búsqueda de mensajes recomendamos el usuario con credenciales `57181678-4` (el pasaporte también es la contraseña), ya que este usuario ha enviado y recibido varios mensajes.

## Funcionalidades para la PDI

Lo pedido en esta parte se encuentra en la sección `Mapa` de la barra de navegación. Dentro de esta sección se encuentra el formulario con los parámetros a ingresar, tales como las fechas, nombre de usuario y palabras clave.

### Consideraciones generales

1. Por consistencia, decidimos también utilizar el nombre de usuario en vez de entregar el id directamente.

2. Los únicos campos obligatorios son los de la fecha inicial y final, tal como se indicó en las issues. No hay que preocuparse del formato, ya que usamos un input de tipo fecha y por detrás nos preocupamos de eso.

3. Las fechas indicadas en la búsqueda son inclusivas

### Consideraciones: Búsqueda sin nombre

1. En el caso de que no se indique un usuario, se realiza la búsqueda según los parámetros indicados dentro de todos los mensajes. La localización de envío de cada mensaje se visualiza en el mapa a través de un pin.

### Consideraciones: Búsqueda con nombre

5. Para el caso de que se ingrese un usuario que sea jefe de instalación, el puerto donde trabaja es señalado con un círculo rojo

6. Para el caso de que se ingrese un usuario que sea capitán, los puertos en los que ha estado el barco donde capitanea se indican con un círculo rojo

7. (Fechas para atraques de capitanes)

8. Puerto nombre lo pusimos en la antártica
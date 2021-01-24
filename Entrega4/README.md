# Entrega 4 IIC2413 - Grupo 99 y 102

Integrantes: Felipe Moya, Eduardo Vásquez, Sebastián León, Fabián Sepúlveda

## Forma de ejecución

# 1.- Aplicación Principal

El código de la aplicación principal, `main.py`, se encuentra en el archivo `Aplicacion.zip`.

# 2.- Entorno Virtual

Para acceder al entorno virtual usado para esta entrega, debes situarte en la carpeta `Entrega4` y 
utilizar el comando `pipenv install` para instalar las dependencias utilizadas en esta aplicación. Luego, para ingresar al entorno virtual se debe utilizar el comando `pipenv shell`. Finalmente, para correr la aplicación, basta con usar `python main.py`.

# 3.- Consultas

## a) GET Básicos

### i.- /messages

Esta ruta está implementada en la función `all_messages()`. Al hacer el llamado a all_messages() se entrega un JSON con los atributos messages y success, donde messages es una lista con todos los mensajes de la base de datos, y success es igual a `true` si es que no hubieron problemas.

Si es que en la url se reciben los dos parámetros `id1`e `id2`, se obtiene un JSON con los atributos messages_id1_to_id2, messages_id2_to_id1 y success. El primer atributo contiene una lista con los mensajes emitidos del usuario con id1 al usuario con id2, el segundo contiene una lista con los mensajes emitidos del usuario con id2 al usuario con id1, mientras que success será igual a `true` si es que no hubieron problemas. En caso de que uno de los dos usuarios no exista en la base de datos, en vez de entregarse los atributos de mensajes se entregará un mensaje de error, y success será igual a false.

### ii.- /messages/:id

Esta ruta está implementada en la función `message_info()`. Al hacer el llamado a este método se entrega un JSON con los atributos message y success, donde message contiene los atributos del mensaje pedido en una lista, y success es igual a `true` si es que no hubieron problemas. Si el id entregado no existe en
la base de datos, success tomará el valor false, y en vez de recibir el atributo message, se recibe un mensaje de error indicando que el id no existe en la base de datos.

### iii.- /users 

Esta ruta está implementada en la función `all_users()`. Al hacer el llamado a este método se entrega un JSON con los atributos users y success, donde users es una lista con todos los usuarios de la base de datos, y success es igual a `true` si es que no hubieron problemas.

### iv.- /users/:id

Esta ruta está implementada en la función `user_info()`. Al hacer el llamado a este método se entrega un JSON con los atributos user_info, user_messages y success, donde user_info es una lista con la información del usuario, user_messages una lista con los mensajes emitidos por el usuario y success es igual a `true` si es que no hubieron problemas. Si el usuario con el id entregado no existe en la base de datos, success tomará el valor false, y en vez de recibir los atributos user_info y user_messages, se recibirá un mensaje de error, error_message, indicando que el id no existe en la base de datos.

## b) GET text-search

La parte de text-search está implementada en el método `text_search()`. Es importante mencionar que nuestro índice utilizado usa el lenguaje `none`, por lo que los resultados esperados deben verse con esa opción. En primera instancia text_search identifica los dos casos donde o no se entrega un body, o se entrega un diccionario vacío, retornando todos los mensajes de la base de datos.

En caso que se reciba un diccionario no vacío, se realiza la búsqueda de mensajes en la base de datos. Para esto, vamos identificado las llaves pedidas para poder generar nuestro string que 
será entregado a mongo para que realice la consulta correspondiente. Además, en un principio creamos una lista vacía, `busqueda_mensajes`, que contendrá todas los mensajes que se entregarán al final de la ejecución.

Lo primero entonces es verificar la presencia de las llaves required y desired. A partir de ambas llaves se genera un string con el cual hacemos una búsqueda dentro de nuestra base de datos con los mensajes que cumplen los criterios, actualizando nuestra lista de mensajes `busqueda_mensajes`, aunque esto solamente si alguna o ambas llaves están presentes. 

Luego, vemos si existe la llave userId, a partir de la cual tenemos dos opciones: Si busqueda de mensajes no es vacío, esto es, alguna de las llaves required o desired estaban presentes, entonces debemos filtrar los mensajes de `busqueda_mensajes`, eliminando todos los mensajes que no sean de este usuario. En caso de que `busqueda_mensajes` sea vacío, solamente tenemos que buscar todos los mensajes de este usuario.

Finalmente, si la llave required está presente, nuevamente tenemos dos casos: El primero es que solamente forbidden esté presente en nuestra base de datos, ante lo cual debemos filtrar todos los mensajes, eliminando aquellos que presenten alguna de las palabras indicadas en required. El segundo caso sería que hay otra llave presente, ante lo cual debemos eliminar de nuestra lista `busqueda_mensajes` todos aquellos mensajes que contengan alguna de nuestras palabras indicadas por forbidden. Así, ya teniendo todo listo, retornamos finalmente la lista de mensajes `busqueda_mensajes`.

## c) POST

### i.- /messages

Esta ruta está implementada en la función `post_message()`, la cual recibe los atributos para ingresar un nuevo mensaje en la base de datos. Esta función siempre retorna el atributo `success`, el cual será true si no hubieron problemas, donde también se entregará el atributo `mid` indicando el id del nuevo mensaje en la base de datos. En caso de que la ejecución falle, se retorna `success` como false, y también se entrega un mensaje de error en `error_message` indicando cual fue el problema.

Primero se chequean dos condiciones: que el body no sea vacío, y que en caso de que no lo sea, que todos los parámetros del mensaje estén. En caso de que alguna condición no se cumpla, se entrega un mensaje de error correspondiente, donde en el segundo caso también se indica cuales fueron exactamente los atributos faltantes.

Luego, en caso de pasar las condiciones anteriores, hacemos una validación de los datos donde se chequea que los tipos de atributos sean los correctos. En caso de que algún o algunos atributos no sean válidos, se indicará en el mensaje de error el nombre de estos. Finalmente, se verifica que los usuarios indicados como emitente y receptor estén en la base de datos, donde en caso contrario se indicará en un mensaje de error que alguno de los dos no existe.

Ya verificando todo lo anterior, se genera un id único para el nuevo mensaje, correspondiente a uno más el máximo id ya presente en la base de datos, y se agrega el nuevo mensaje.

## d) DELETE

### i.- /message/:id

Esta ruta está implementada en la función `delete_message()`, la cual recibe el id del mensaje que se desea eliminar. Esta función siempre retorna el atributo `success`, el cual será true si no hubieron problemas al eliminar el mensaje, esto es, el mensaje con id entregado sí existe en la base de datos. En caso de que el id entregado no exista en la base de datos, `success` tomará el valor false y se entregará un mensaje de error a través del atributo `error_message` indicando que no existe un mensaje en la base de datos con el id indicado.

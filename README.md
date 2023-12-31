# Local environment setup

Este README documentará todos los pasos necesarios para poner en marcha la aplicación.

## ERD (Diagrama de entidad-relación)

![](/app/assets/images/erd.png)


## Configuraciones

Necesitarás tener [Docker](https://docs.docker.com/get-docker/) instalado. Está disponible en Windows, macOS y la
mayoría de las distribuciones de Linux.

#### Antes de crear su aplicación:

Debe crear un archivo .env en la raíz del proyecto y añadir las siguiente variables de entorno:

```
POSTGRES_HOST=db
POSTGRES_USER=<postgres_username>
POSTGRES_PASSWORD=<postgres_password>
```

#### Construir todo para el entorno de desarrollo:

Previamente descargados los proyectos, procedemos a ejecutar nuestro docker-compose.yml único ubicado en el repositorio
que se encargará de subir y ejecutar todos los servicios que hemos dockerizado

```bash
docker-compose up -d
```

##### Lista todos los contenedores creados

```bash
docker ps
```

##### Configurar la aplicación Ruby:

Para llevar a cabo la configuración de la aplicación, es imprescindible acceder al intérprete de comandos (bash) del
contenedor en el que se está ejecutando. Puedes hacerlo con el siguiente comando:

```bash
docker exec -it <container_id> bash
```

Para crear la base de datos debe ejecutar el siguiente comando:

```bash
rails db:create
```

Ejecute las migraciones y las semillas si es necesario:

```bash
rails db:migrate
rails db:seed
```

Recuerde que siempre puede detener la aplicación y los servicios de contenedor relacionados con el siguiente comando:

```bash
docker compose down
```

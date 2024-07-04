Este `README.md` proporciona una guía completa para configurar y ejecutar un proyecto Laravel dentro de un contenedor Docker utilizando MariaDB como base de datos. Incluye pasos detallados para clonar el repositorio, configurar los archivos necesarios, construir y levantar los contenedores, y solucionar problemas comunes.

# Laravel Docker Development Environment

Este proyecto proporciona un entorno de desarrollo para Laravel utilizando Docker. Incluye servicios para PHP, Apache, MariaDB y phpMyAdmin.

## Requisitos

- Docker
- Docker Compose

## Instrucciones

### 1. Clonar el Repositorio

Clona el repositorio de tu proyecto Laravel:

```bash
git clone https://github.com/tu-usuario/tu-proyecto-laravel.git
```

### 2. Construir y Levantar los Contenedores
Construye y levanta los contenedores Docker:

```bash
docker-compose up --build -d
```
### 3. Generar la Clave de la Aplicación
Genera la clave de la aplicación Laravel:

```bash
docker-compose exec app php artisan key:generate
```
### 4.Migrar la Base de Datos
Ejecuta las migraciones de la base de datos:

```bash
docker-compose exec app php artisan migrate
```
### 5.Ejecutamos con:
```bash
docker-compose exec app bash -c 'cd laravel && php artisan serve --host=0.0.0.0 --port=8000'
```

###  Acceder a la Aplicación
Tu aplicación Laravel debería estar disponible en http://localhost:8000.
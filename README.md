# Bolsa de Trabajo

Plataforma web de bolsa de trabajo construida con Django y MySQL. Incluye triggers de auditoría, tablas históricas y jobs DBA automáticos.

## Requisitos

- Python 3.13+
- MySQL/MariaDB 10.1+
- pip (gestor de paquetes de Python)

## Instalación para colaboradores

### 1. Clonar el repositorio

```bash
git clone <repo-url>
cd bolsa_trabajo
```

### 2. Crear y activar entorno virtual

```bash
python -m venv venv
source venv/bin/activate  # Linux/Mac
# o venv\Scripts\activate  # Windows
```

### 3. Instalar dependencias

```bash
pip install -r requirements.txt
```

### 4. Configurar la base de datos MySQL

```bash
# Acceder a MySQL como root
mysql -u root -p
```

```sql
-- Crear base de datos
CREATE DATABASE bolsa_trabajo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Crear usuario
CREATE USER 'django_user'@'localhost' IDENTIFIED BY 'MIRT2025$$';
GRANT ALL PRIVILEGES ON bolsa_trabajo.* TO 'django_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 5. Importar esquema de base de datos

Este archivo contiene TODAS las tablas, triggers históricos, eventos DBA y procedimientos almacenados:

```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < bolsa_trabajo_schema.sql
```

> **Alternativa**: Si prefieres empezar desde cero, puedes ejecutar `python manage.py migrate` pero **no tendrás los triggers DBA**. Para obtenerlos, ejecuta también `bolsa_trabajo_mysql_dba.sql` en la BD.

### 6. Ejecutar servidor de desarrollo

```bash
python manage.py runserver
```

Abrir en el navegador: http://127.0.0.1:8000/
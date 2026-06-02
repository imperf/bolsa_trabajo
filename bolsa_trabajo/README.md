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

### 6. Cargar datos de ejemplo (opcional)

Los datos demo se cargan automáticamente al registrar usuarios desde la web. Para datos iniciales rápidos:

```bash
python manage.py shell
```

```python
from django.contrib.auth.models import User
from empleos.models import Empresa, Categoria, Vacante, Perfil

# Superadmin
u = User.objects.create_superuser('admin', 'admin@example.com', 'admin123')
Perfil.objects.create(usuario=u, tipo_usuario='empresa')

# Categorías
for c in ['Desarrollo Web', 'Data Science', 'Diseño UX/UI', 'Marketing Digital', 'Recursos Humanos']:
    Categoria.objects.create(nombre=c)

# Empresa
emp = Empresa.objects.create(
    nombre='Tech Solutions SV',
    descripcion='Empresa líder en soluciones tecnológicas en El Salvador',
    direccion='San Salvador', telefono='2222-3333',
    correo='info@techsolutions.com.sv',
)

# Vacantes de ejemplo
Vacante.objects.create(titulo='Desarrollador Frontend React', empresa=emp,
    categoria=Categoria.objects.get(nombre='Desarrollo Web'),
    salario=1500, ubicacion='San Salvador',
    descripcion='Experiencia en React y Tailwind CSS.',
    fecha_limite='2026-07-01', requisitos='Experiencia comprobable')
```

### 7. Ejecutar servidor de desarrollo

```bash
python manage.py runserver
```

Abrir en el navegador: http://127.0.0.1:8000/

## Estructura del proyecto

```
bolsa_trabajo/
├── bolsa_trabajo/           # Configuración del proyecto Django
│   ├── settings.py          # Conexión a MySQL
│   ├── urls.py              # Rutas principales
│   └── wsgi.py              # Punto de entrada WSGI
├── empleos/                 # Aplicación principal
│   ├── models.py            # Modelos ORM (Empresa, Vacante, Candidato, etc.)
│   ├── views.py             # Vistas con ORM de Django
│   ├── urls.py              # Rutas de la aplicación
│   └── templates/empleos/   # Plantillas HTML (Tailwind CSS)
├── bolsa_trabajo_schema.sql # Dump completo del esquema MySQL con triggers
├── bolsa_trabajo_MySQL (1).sql  # DDL original de las tablas legacy
├── bolsa_trabajo_mysql_dba.sql  # Triggers y jobs DBA originales
├── db.sqlite3               # Base de datos (solo si usas SQLite)
└── requirements.txt         # Dependencias Python
```

## Funcionalidades DBA

### Triggers de auditoría
- **BEFORE INSERT**: Llenan automáticamente `creado_por` y `fecha_creacion`
- **BEFORE UPDATE**: Llenan `modificado_por` y `fecha_modificacion`

### Triggers históricos
- **AFTER UPDATE**: Guardan snapshot del registro anterior en tabla `hist_*`
- **BEFORE DELETE**: Guardan snapshot antes de eliminar

### Eventos de mantenimiento (5 jobs)
- `job_purgar_notificaciones` → Diario (01:00) - Limpia notificaciones viejas
- `job_purgar_historicos` → Mensual (día 1, 02:00) - Purga hist_* > 2 años
- `job_optimizar_tablas` → Semanal (domingo, 03:00) - Reconstruye tablas
- `job_matar_conexiones_dormidas` → Cada 30 min - Mata conexiones Sleep
- `job_actualizar_estadisticas` → Diario (04:00) - Refresca estadísticas

## Exportar para compartir

Para exportar el estado actual de tu base de datos (con datos) para que otro colaborador lo importe:

```bash
# Solo esquema (sin datos) - recomendado para desarrollo
mysqldump -u django_user -p'MIRT2025$$' --no-data --routines --events --triggers bolsa_trabajo > bolsa_trabajo_schema.sql

# Esquema + datos (para copias completas)
mysqldump -u django_user -p'MIRT2025$$' --routines --events --triggers bolsa_trabajo > bolsa_trabajo_full.sql
```

El otro desarrollador importa con:
```bash
mysql -u django_user -p'<su_password>' bolsa_trabajo < bolsa_trabajo_schema.sql
```

## Credenciales demo

- **Admin**: admin / admin123
- **Usuario tipo empresa**: registrarse desde `/registro/`
- **Usuario tipo candidato**: registrarse desde `/registro/`
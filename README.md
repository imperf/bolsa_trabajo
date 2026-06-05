# Bolsa de Trabajo

Plataforma web de bolsa de trabajo construida con Django y MySQL. Permite a empresas publicar ofertas de empleo y a candidatos buscar, filtrar y postularse a vacantes.

## Características Principales

### Para Empresas
- Publicar, editar y eliminar ofertas de empleo
- Gestionar postulaciones con estados: Pendiente → En Revisión → Preselección → Contratado/Rechazado
- Ver perfiles completos de candidatos
- Recibir notificaciones de nuevas postulaciones
- Dashboard con estadísticas del sistema

### Para Candidatos
- Buscar empleos con filtros: Área profesional, Ubicación, Tipo de contrato, Nivel de experiencia
- Postularse a ofertas de empleo
- Ver estado de postulaciones en tiempo real
- Editar perfil profesional (experiencia, estudios, habilidades)
- Seleccionar categorías de interés para recibir notificaciones
- Recibir notificaciones de nuevas ofertas y cambios de estado

### Para Administradores
- Panel de administración completo (`/admin-panel/`)
- Gestionar usuarios, empresas, vacantes y categorías
- Eliminar cualquier registro del sistema
- Ver estadísticas globales

### Sistema de Notificaciones
- Notificación automática cuando se publica una oferta que coincide con los intereses del candidato
- Notificación cuando cambia el estado de una postulación
- Badge con contador de notificaciones sin leer

### Estados de Postulación
1. **Pendiente** - Postulación recibida
2. **En Revisión** - Siendo evaluada por la empresa
3. **Preselección** - Candidato preseleccionado
4. **Contratado** - Candidato contratado
5. **Rechazado** - No seleccionado

## Requisitos

- Python 3.13+
- MySQL 8.0+ o MariaDB 10.1+
- pip (gestor de paquetes de Python)

> **Nota para usuarios de MySQL:** Los dumps usan la colación `utf8mb4_uca1400_ai_ci` (específica de MariaDB) en las tablas legacy. Si usas MySQL, ejecuta este comando en el directorio del proyecto antes de importar:
> ```bash
> sed -i 's/utf8mb4_uca1400_ai_ci/utf8mb4_unicode_ci/g' bolsa_trabajo_backup_completo.sql bolsa_trabajo_deploy.sql bolsa_trabajo_schema.sql
> ```

## Instalación para colaboradores

### 1. Clonar el repositorio

```bash
git clone https://github.com/imperf/bolsa_trabajo.git
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
mysql -u root -p
```

```sql
CREATE DATABASE bolsa_trabajo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'django_user'@'localhost' IDENTIFIED BY 'MIRT2025$$';
GRANT ALL PRIVILEGES ON bolsa_trabajo.* TO 'django_user'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 5. Importar base de datos

**Opción A - Backup completo (con datos, eventos y procedimientos):**
```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < bolsa_trabajo_backup_completo.sql
```

**Opción B - Backup de deployment (solo con datos, sin triggers ni eventos):**
```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < bolsa_trabajo_deploy.sql
```

**Opción C - Empezar desde cero (solo estructura, sin datos):**
```bash
python manage.py migrate
```
> Nota: Con esta opción no tendrás datos de ejemplo, categorías, ni usuario admin. Tendrás que crearlos manualmente.

> **Importante:** Las opciones A y B no requieren ejecutar `migrate` ya que los dumps incluyen el esquema completo y la tabla `django_migrations` con todas las migraciones marcadas como aplicadas.

### 5b. Crear triggers y tablas de auditoría (requerido para todas las opciones)

Después de importar la base de datos (o ejecutar migrate), crear las tablas de historial y los triggers de auditoría:

```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < empleos_triggers_update.sql
```

> Nota: Los dumps no incluyen triggers inline para evitar errores de orden de tablas. Este script crea las tablas de historial primero y luego los triggers, evitando el problema. Django migrations no crea triggers de MySQL, por lo que este paso es siempre necesario.

### 5c. Crear eventos programados y procedimientos almacenados (opcional, requiere root)

Para activar los jobs de mantenimiento automático (purgar históricos, optimizar tablas, matar conexiones dormidas, etc.):

```bash
mysql -u root -p bolsa_trabajo < empleos_jobs.sql
```

> Nota: Este paso requiere privilegios de root ya que crea eventos programados (`EVENT`) y procedimientos almacenados (`PROCEDURE`). El event scheduler de MySQL debe estar activado (`SET GLOBAL event_scheduler = ON;`). Este paso es opcional para desarrollo local.

### 6. Ejecutar servidor de desarrollo

```bash
python manage.py runserver
```

Abrir en el navegador: http://127.0.0.1:8000/

## Cuentas de Ejemplo (si se importa el backup)

| Usuario | Tipo | Contraseña |
|---------|------|------------|
| admin | Administrador (Superuser) | admin123 |
| TECNASA | Empresa | 1234 |
| Juanito | Candidato | 1234|
| Kevin | Candidato | 1234 |
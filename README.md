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
- MySQL/MariaDB 10.1+
- pip (gestor de paquetes de Python)

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

**Opción A - Backup completo (con triggers, datos, eventos y procedimientos):**
```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < bolsa_trabajo_backup_completo.sql
```

**Opción B - Backup de deployment (con triggers y datos, sin eventos ni procedimientos):**
```bash
mysql -u django_user -p'MIRT2025$$' bolsa_trabajo < bolsa_trabajo_deploy.sql
```

**Opción C - Empezar desde cero (solo estructura, sin datos):**
```bash
python manage.py migrate
```
> Nota: Con esta opción no tendrás datos de ejemplo, categorías, ni usuario admin. Tendrás que crearlos manualmente.

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
from django.db import models
from django.contrib.auth.models import User


# =========================
# EMPRESA
# =========================
class Empresa(models.Model):
    nombre = models.CharField(max_length=150)
    descripcion = models.TextField()
    direccion = models.CharField(max_length=255)
    telefono = models.CharField(max_length=20)
    correo = models.EmailField()
    sitio_web = models.URLField(blank=True, null=True)

    def __str__(self):
        return self.nombre


# =========================
# CATEGORÍA
# =========================
class Categoria(models.Model):
    nombre = models.CharField(max_length=100)

    def __str__(self):
        return self.nombre


# =========================
# VACANTES
# =========================
class Vacante(models.Model):
    ESTADOS = [
        ('ACTIVA', 'Activa'),
        ('CERRADA', 'Cerrada'),
    ]

    titulo = models.CharField(max_length=200)
    empresa = models.ForeignKey(
        Empresa,
        on_delete=models.CASCADE
    )
    categoria = models.ForeignKey(
        Categoria,
        on_delete=models.SET_NULL,
        null=True
    )
    descripcion = models.TextField()
    requisitos = models.TextField()
    salario = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True
    )
    ubicacion = models.CharField(max_length=150)
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='ACTIVA'
    )
    fecha_publicacion = models.DateTimeField(auto_now_add=True)
    fecha_limite = models.DateField()

    def __str__(self):
        return self.titulo


# =========================
# CANDIDATOS
# =========================
class Candidato(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE
    )
    telefono = models.CharField(max_length=20)
    direccion = models.CharField(max_length=255)
    curriculum = models.FileField(
        upload_to='cv/',
        null=True,
        blank=True
    )
    experiencia = models.TextField()

    def __str__(self):
        return self.user.username


# =========================
# POSTULACIONES
# =========================
class Postulacion(models.Model):
    ESTADOS = [
        ('PENDIENTE', 'Pendiente'),
        ('ACEPTADO', 'Aceptado'),
        ('RECHAZADO', 'Rechazado'),
    ]

    candidato = models.ForeignKey(
        Candidato,
        on_delete=models.CASCADE
    )
    vacante = models.ForeignKey(
        Vacante,
        on_delete=models.CASCADE
    )
    fecha_postulacion = models.DateTimeField(auto_now_add=True)
    estado = models.CharField(
        max_length=20,
        choices=ESTADOS,
        default='PENDIENTE'
    )
    mensaje = models.TextField(blank=True, null=True)

    def __str__(self):
        return f"{self.candidato} -> {self.vacante}"


# =========================
# PERFIL (Extensión de Usuario)
# =========================
class Perfil(models.Model):
    TIPO_USUARIO = [
        ('empresa', 'Empresa/Reclutador'),
        ('candidato', 'Candidato'),
    ]

    usuario = models.OneToOneField(User, on_delete=models.CASCADE)
    tipo_usuario = models.CharField(
        max_length=20,
        choices=TIPO_USUARIO
    )

    def __str__(self):
        return f"{self.usuario.username} - {self.tipo_usuario}"
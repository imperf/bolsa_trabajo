from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth import get_user_model


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
    persona_contacto = models.CharField(max_length=100, blank=True, default='')
    sector = models.CharField(max_length=100, blank=True, default='')

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

    TIPOS_CONTRATO = [
        ('TIEMPO_COMPLETO', 'Tiempo Completo'),
        ('MEDIO_TIEMPO', 'Medio Tiempo'),
        ('TEMPORAL', 'Temporal'),
        ('PRACTICAS', 'Prácticas'),
        ('PROYECTO', 'Por Proyecto'),
    ]

    NIVELES_EXPERIENCIA = [
        ('SIN_EXPERIENCIA', 'Sin experiencia'),
        ('JUNIOR', 'Junior (1-2 años)'),
        ('MID_LEVEL', 'Mid-Level (3-5 años)'),
        ('SENIOR', 'Senior (5-8 años)'),
        ('EXPERT', 'Expert (+8 años)'),
    ]

    titulo = models.CharField(max_length=200)
    empresa = models.ForeignKey(
        Empresa,
        on_delete=models.CASCADE
    )
    creado_por_usuario = models.ForeignKey(
        get_user_model(),
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name='vacantes_creadas'
    )
    categoria = models.ForeignKey(
        Categoria,
        on_delete=models.SET_NULL,
        null=True
    )
    descripcion = models.TextField()
    requisitos = models.TextField()
    experiencia = models.TextField(blank=True, default='')
    nivel_experiencia = models.CharField(
        max_length=20,
        choices=NIVELES_EXPERIENCIA,
        default='SIN_EXPERIENCIA'
    )
    salario = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        null=True,
        blank=True
    )
    ubicacion = models.CharField(max_length=150)
    tipo_contrato = models.CharField(
        max_length=20,
        choices=TIPOS_CONTRATO,
        default='TIEMPO_COMPLETO'
    )
    numero_vacantes = models.PositiveIntegerField(default=1)
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
    dui = models.CharField(max_length=20, blank=True, default='')
    area_interes = models.CharField(max_length=100, blank=True, default='')
    categorias_interes = models.ManyToManyField(
        Categoria,
        blank=True,
        related_name='candidatos_interesados',
        verbose_name='Categorías de interés'
    )
    estudios = models.TextField(blank=True, default='')
    habilidades = models.TextField(blank=True, default='')

    def __str__(self):
        return self.user.username


# =========================
# POSTULACIONES
# =========================
class Postulacion(models.Model):
    ESTADOS = [
        ('PENDIENTE', 'Pendiente'),
        ('EN_REVISION', 'En Revisión'),
        ('PRESELECCION', 'Preselección'),
        ('CONTRATADO', 'Contratado'),
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


# =========================
# NOTIFICACIONES
# =========================
class Notificacion(models.Model):
    TIPOS = [
        ('NUEVO_EMPLEO', 'Nuevo Empleo'),
        ('CAMBIO_ESTADO', 'Cambio de Estado'),
        ('SISTEMA', 'Sistema'),
    ]

    usuario = models.ForeignKey(
        User,
        on_delete=models.CASCADE,
        related_name='notificaciones'
    )
    titulo = models.CharField(max_length=200)
    mensaje = models.TextField()
    tipo = models.CharField(
        max_length=20,
        choices=TIPOS,
        default='SISTEMA'
    )
    leida = models.BooleanField(default=False)
    fecha_creacion = models.DateTimeField(auto_now_add=True)
    url = models.CharField(max_length=500, blank=True, default='')

    class Meta:
        ordering = ['-fecha_creacion']

    def __str__(self):
        return f"{self.titulo} - {self.usuario.username}"

    def marcar_como_leida(self):
        self.leida = True
        self.save()

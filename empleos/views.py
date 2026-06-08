from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages
from django.core.exceptions import PermissionDenied
from .models import Vacante, Empresa, Categoria, Perfil, Candidato, Postulacion, Notificacion


def inicio(request):
    return render(request, 'empleos/inicio.html')


def lista_empleos(request):
    """
    Lista de empleos con filtros de búsqueda para candidatos.
    Filtros disponibles: area profesional (categoria), ubicación, tipo de trabajo, nivel de experiencia.
    """
    # Obtener vacantes activas
    vacantes = Vacante.objects.filter(estado='ACTIVA').select_related('empresa', 'categoria')
    
    # Filtros de búsqueda
    categoria_id = request.GET.get('categoria', '')
    ubicacion = request.GET.get('ubicacion', '')
    tipo_contrato = request.GET.get('tipo_contrato', '')
    nivel_experiencia = request.GET.get('nivel_experiencia', '')
    
    # Aplicar filtros
    if categoria_id:
        vacantes = vacantes.filter(categoria_id=categoria_id)
    if ubicacion:
        vacantes = vacantes.filter(ubicacion__icontains=ubicacion)
    if tipo_contrato:
        vacantes = vacantes.filter(tipo_contrato=tipo_contrato)
    if nivel_experiencia:
        vacantes = vacantes.filter(nivel_experiencia=nivel_experiencia)
    
    # Obtener categorías para el filtro
    categorias = Categoria.objects.all()
    
    # Obtener opciones únicas de ubicación para el filtro
    ubicaciones = Vacante.objects.filter(estado='ACTIVA').values_list('ubicacion', flat=True).distinct()
    
    context = {
        'vacantes': vacantes,
        'categorias': categorias,
        'ubicaciones': ubicaciones,
        'filtro_categoria': categoria_id,
        'filtro_ubicacion': ubicacion,
        'filtro_tipo_contrato': tipo_contrato,
        'filtro_nivel_experiencia': nivel_experiencia,
    }
    
    return render(request, 'empleos/lista_empleos.html', context)


def detalle_empleo(request, vacante_id):
    """
    Mostrar detalles de una vacante y permitir postulaciones.
    """
    vacante = get_object_or_404(Vacante.objects.select_related('empresa', 'categoria'), pk=vacante_id)
    
    # Verificar si el usuario ya se postuló a esta vacante
    ya_postulado = False
    if request.user.is_authenticated:
        try:
            candidato = request.user.candidato
            ya_postulado = Postulacion.objects.filter(candidato=candidato, vacante=vacante).exists()
        except (AttributeError, Candidato.DoesNotExist):
            pass
    
    context = {
        'vacante': vacante,
        'ya_postulado': ya_postulado,
    }
    
    return render(request, 'empleos/detalle_empleo.html', context)


@login_required
def postular_empleo(request, vacante_id):
    """
    Permitir que un candidato se postule a una vacante.
    """
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    # Solo candidatos pueden postularse
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'candidato':
            messages.error(request, 'Solo los candidatos pueden postularse a ofertas de empleo.')
            return redirect('lista_empleos')
        
        candidato = request.user.candidato
    except (Perfil.DoesNotExist, Candidato.DoesNotExist):
        messages.error(request, 'Debes completar tu perfil de candidato para postularse.')
        return redirect('inicio')
    
    # Verificar si ya se postuló
    if Postulacion.objects.filter(candidato=candidato, vacante=vacante).exists():
        messages.warning(request, 'Ya te has postulado a esta oferta anteriormente.')
        return redirect('detalle_empleo', vacante_id=vacante.id)
    
    if request.method == 'POST':
        mensaje = request.POST.get('mensaje', '')
        
        Postulacion.objects.create(
            candidato=candidato,
            vacante=vacante,
            mensaje=mensaje
        )
        
        messages.success(request, '¡Te has postulado exitosamente a esta oferta!')
        return redirect('lista_empleos')
    
    return render(request, 'empleos/postular_empleo.html', {
        'vacante': vacante,
        'candidato': candidato,
    })


def empresas(request):
    # Obtener empresas usando el ORM de Django
    lista_de_empresas = Empresa.objects.all()
    return render(
        request, 
        'empleos/empresas.html', 
        {
            'empresas': lista_de_empresas
        }
    )


def login_view(request):
    if request.method == 'POST':
        usuario_o_correo = request.POST.get('username') 
        clave = request.POST.get('password')
        
        # Autenticar con Django auth
        user = authenticate(request, username=usuario_o_correo, password=clave)
        
        if user is not None:
            login(request, user)
            
            # Admin users go to admin panel
            if user.is_superuser or user.is_staff:
                return redirect('admin_panel')
            
            try:
                if user.perfil.tipo_usuario == 'empresa':
                    return redirect('dashboard')
                else:
                    return redirect('inicio')
            except (AttributeError, Perfil.DoesNotExist):
                return redirect('inicio')
        else:
            return render(request, 'empleos/login.html', {
                'error': 'Usuario o contraseña incorrectos',
                'datos': request.POST
            })
            
    return render(request, 'empleos/login.html')


def registro(request):
    from django.contrib.auth.models import User
    from .models import Candidato, Empresa

    if request.method == 'POST':
        usuario = request.POST.get('usuario')
        clave = request.POST.get('password')
        tipo = request.POST.get('tipo_usuario')  # 'empresa' or 'candidato'

        # Datos específicos según tipo de usuario
        if tipo == 'candidato':
            nombre_completo = request.POST.get('nombre')
            correo = request.POST.get('email')
            telefono = request.POST.get('telefono')
            experiencia = request.POST.get('experiencia', '')
            dui = request.POST.get('dui', '')
            estudios = request.POST.get('estudios', '')
            habilidades = request.POST.get('habilidades', '')
            area_interes = request.POST.get('area_interes', '')

            # Crear usuario usando Django ORM
            user = User.objects.create_user(
                username=usuario,
                email=correo,
                password=clave,
                first_name=nombre_completo
            )

            # Crear perfil asociado
            Perfil.objects.create(
                usuario=user,
                tipo_usuario=tipo
            )

            # Crear candidato con todos los campos
            Candidato.objects.create(
                user=user,
                telefono=telefono,
                direccion='',
                experiencia=experiencia,
                dui=dui,
                estudios=estudios,
                habilidades=habilidades,
                area_interes=area_interes
            )

        elif tipo == 'empresa':
            nombre_empresa = request.POST.get('nombre_empresa')
            direccion = request.POST.get('direccion_empresa', '')
            telefono = request.POST.get('telefono_empresa')
            correo = request.POST.get('email_empresa')
            sector = request.POST.get('sector', '')
            persona_contacto = request.POST.get('persona_contacto', '')

            # Crear usuario usando Django ORM
            user = User.objects.create_user(
                username=usuario,
                email=correo,
                password=clave,
                first_name=nombre_empresa
            )

            # Crear perfil asociado
            Perfil.objects.create(
                usuario=user,
                tipo_usuario=tipo
            )

            # Crear empresa con todos los campos
            Empresa.objects.create(
                nombre=nombre_empresa,
                descripcion='',
                direccion=direccion,
                telefono=telefono,
                correo=correo,
                sector=sector,
                persona_contacto=persona_contacto
            )

        else:
            # Fallback: tipo de usuario no reconocido
            return render(request, 'empleos/registro.html', {
                'error': 'Tipo de usuario no válido'
            })

        return redirect('login')

    return render(request, 'empleos/registro.html')


@login_required
def dashboard(request):
    """
    Dashboard principal con estadísticas reales del sistema.
    """
    from django.db.models import Count
    
    # Estadísticas reales
    empleos_activos = Vacante.objects.filter(estado='ACTIVA').count()
    total_empresas = Empresa.objects.count()
    total_usuarios = User.objects.count()
    total_aplicaciones = Postulacion.objects.count()
    
    # Últimas publicaciones (más recientes primero)
    vacantes = Vacante.objects.filter(estado='ACTIVA').select_related('empresa').order_by('-fecha_publicacion')[:10]
    
    return render(request, 'empleos/dashboard.html', {
        'vacantes': vacantes,
        'empleos_activos': empleos_activos,
        'total_empresas': total_empresas,
        'total_usuarios': total_usuarios,
        'total_aplicaciones': total_aplicaciones,
    })


@login_required
def publicar_empleo(request):
    # Verificar que el usuario sea una empresa
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden publicar ofertas de empleo.')
            return redirect('inicio')
        
        # Obtener la empresa asociada al usuario
        empresa = Empresa.objects.get(correo=request.user.email)
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada. Por favor registra tu empresa primero.')
        return redirect('registro')
    
    if request.method == 'POST':
        titulo = request.POST.get('titulo')
        ubicacion = request.POST.get('ubicacion')
        categoria_id = request.POST.get('categoria')
        salario = request.POST.get('salario')
        descripcion = request.POST.get('descripcion')
        requisitos = request.POST.get('requisitos')
        experiencia = request.POST.get('experiencia', '')
        nivel_experiencia = request.POST.get('nivel_experiencia', 'SIN_EXPERIENCIA')
        fecha_limite = request.POST.get('fecha_limite')
        tipo_contrato = request.POST.get('tipo_contrato', 'TIEMPO_COMPLETO')
        numero_vacantes = request.POST.get('numero_vacantes', 1)

        # Sanitización de salarios
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
            try:
                salario = float(salario)
            except ValueError:
                salario = None
        else:
            salario = None

        # Sanitización de numero_vacantes
        try:
            numero_vacantes = int(numero_vacantes)
            if numero_vacantes < 1:
                numero_vacantes = 1
        except (ValueError, TypeError):
            numero_vacantes = 1

        categoria_obj = Categoria.objects.get(id=categoria_id) if categoria_id else None

        # Crear vacante usando el ORM de Django
        vacante = Vacante.objects.create(
            titulo=titulo,
            empresa=empresa,
            creado_por_usuario=request.user,
            ubicacion=ubicacion,
            categoria=categoria_obj,
            salario=salario,
            descripcion=descripcion,
            requisitos=requisitos,
            experiencia=experiencia,
            nivel_experiencia=nivel_experiencia,
            fecha_limite=fecha_limite,
            tipo_contrato=tipo_contrato,
            numero_vacantes=numero_vacantes
        )
        
        # Notificar a candidatos interesados en esta categoría
        if categoria_obj:
            candidatos_interesados = Candidato.objects.filter(
                categorias_interes=categoria_obj
            ).select_related('user')
            
            for candidato in candidatos_interesados:
                Notificacion.objects.create(
                    usuario=candidato.user,
                    titulo=f'Nueva oferta en {categoria_obj.nombre}',
                    mensaje=f'Se publicó una nueva oferta: "{titulo}" en {ubicacion}. ¡Echa un vistazo!',
                    tipo='NUEVO_EMPLEO',
                    url=f'/empleo/{vacante.id}/'
                )
            
            if candidatos_interesados.count() > 0:
                messages.info(request, f'Se notificó a {candidatos_interesados.count()} candidato(s) interesado(s) en esta categoría.')
            
        messages.success(request, '¡Oferta de empleo publicada exitosamente!')
        return redirect('lista_empleos')

    # Obtener categorías para el formulario
    categorias = Categoria.objects.all()
    
    return render(request, 'empleos/publicar_empleo.html', {
        'categorias': categorias,
        'empresa': empresa
    })


@login_required
def editar_empleo(request, vacante_id):
    """
    Editar una oferta de empleo. Solo la empresa propietaria puede editarla.
    """
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    # Verificar que el usuario sea una empresa y sea la propietaria de la vacante
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden editar ofertas de empleo.')
            return redirect('inicio')
        
        empresa = Empresa.objects.get(correo=request.user.email)
        
        # Verificar que la vacante pertenezca a esta empresa
        if vacante.empresa != empresa:
            raise PermissionDenied('No tienes permiso para editar esta oferta de empleo.')
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada.')
        return redirect('registro')
    
    if request.method == 'POST':
        vacante.titulo = request.POST.get('titulo')
        vacante.ubicacion = request.POST.get('ubicacion')
        vacante.descripcion = request.POST.get('descripcion')
        vacante.requisitos = request.POST.get('requisitos')
        vacante.experiencia = request.POST.get('experiencia', '')
        vacante.nivel_experiencia = request.POST.get('nivel_experiencia', 'SIN_EXPERIENCIA')
        vacante.fecha_limite = request.POST.get('fecha_limite')
        vacante.tipo_contrato = request.POST.get('tipo_contrato', 'TIEMPO_COMPLETO')
        vacante.numero_vacantes = request.POST.get('numero_vacantes', 1)
        
        # Sanitización de salario
        salario = request.POST.get('salario')
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
            try:
                vacante.salario = float(salario)
            except ValueError:
                vacante.salario = None
        else:
            vacante.salario = None
        
        # Sanitización de numero_vacantes
        try:
            vacante.numero_vacantes = int(vacante.numero_vacantes)
            if vacante.numero_vacantes < 1:
                vacante.numero_vacantes = 1
        except (ValueError, TypeError):
            vacante.numero_vacantes = 1
        
        # Obtener categoría
        categoria_id = request.POST.get('categoria')
        if categoria_id:
            vacante.categoria = Categoria.objects.get(id=categoria_id)
        else:
            vacante.categoria = None
        
        vacante.save()
        messages.success(request, '¡Oferta de empleo actualizada exitosamente!')
        return redirect('lista_empleos')
    
    # Obtener categorías para el formulario
    categorias = Categoria.objects.all()
    
    return render(request, 'empleos/editar_empleo.html', {
        'vacante': vacante,
        'categorias': categorias,
        'empresa': empresa
    })


@login_required
def eliminar_empleo(request, vacante_id):
    """
    Eliminar una oferta de empleo. Solo la empresa propietaria puede eliminarla.
    """
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    # Verificar que el usuario sea una empresa y sea la propietaria de la vacante
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden eliminar ofertas de empleo.')
            return redirect('inicio')
        
        empresa = Empresa.objects.get(correo=request.user.email)
        
        # Verificar que la vacante pertenezca a esta empresa
        if vacante.empresa != empresa:
            raise PermissionDenied('No tienes permiso para eliminar esta oferta de empleo.')
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada.')
        return redirect('registro')
    
    if request.method == 'POST':
        vacante.delete()
        messages.success(request, '¡Oferta de empleo eliminada exitosamente!')
        return redirect('dashboard')
    
    return render(request, 'empleos/confirmar_eliminacion.html', {'vacante': vacante})


@login_required
def mis_empleos(request):
    """
    Mostrar las ofertas de empleo publicadas por la empresa usuaria.
    """
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden ver sus ofertas.')
            return redirect('inicio')
        
        empresa = Empresa.objects.get(correo=request.user.email)
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada.')
        return redirect('registro')
    
    vacantes = Vacante.objects.filter(empresa=empresa).select_related('categoria').order_by('-fecha_publicacion')
    
    return render(request, 'empleos/mis_empleos.html', {
        'vacantes': vacantes,
        'empresa': empresa
    })


@login_required
def postulaciones_vacante(request, vacante_id):
    """
    Mostrar las postulaciones de una vacante específica (solo para la empresa propietaria).
    """
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    # Verificar que el usuario sea una empresa y sea la propietaria de la vacante
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden ver postulaciones.')
            return redirect('inicio')
        
        empresa = Empresa.objects.get(correo=request.user.email)
        
        if vacante.empresa != empresa:
            raise PermissionDenied('No tienes permiso para ver las postulaciones de esta oferta.')
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada.')
        return redirect('registro')
    
    # Obtener postulaciones con información del candidato
    postulaciones = Postulacion.objects.filter(vacante=vacante).select_related('candidato__user').order_by('-fecha_postulacion')
    
    return render(request, 'empleos/postulaciones_vacante.html', {
        'vacante': vacante,
        'postulaciones': postulaciones,
        'empresa': empresa,
    })


@login_required
def actualizar_estado_postulacion(request, postulacion_id, estado):
    """
    Actualizar el estado de una postulación (ACEPTADO o RECHAZADO).
    """
    postulacion = get_object_or_404(Postulacion, pk=postulacion_id)
    
    # Verificar que el usuario sea la empresa propietaria de la vacante
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden actualizar el estado de postulaciones.')
            return redirect('inicio')
        
        empresa = Empresa.objects.get(correo=request.user.email)
        
        if postulacion.vacante.empresa != empresa:
            raise PermissionDenied('No tienes permiso para actualizar esta postulación.')
    except (Perfil.DoesNotExist, Empresa.DoesNotExist):
        messages.error(request, 'No tienes una empresa asociada.')
        return redirect('registro')
    
    # Actualizar estado
    estados_validos = ['PENDIENTE', 'EN_REVISION', 'PRESELECCION', 'CONTRATADO', 'RECHAZADO']
    if estado in estados_validos:
        estado_anterior = postulacion.get_estado_display()
        postulacion.estado = estado
        postulacion.save()
        
        # Notificar al candidato del cambio de estado
        mensaje_notificacion = ''
        if estado == 'EN_REVISION':
            mensaje_notificacion = f'Tu postulación para "{postulacion.vacante.titulo}" está siendo revisada.'
        elif estado == 'PRESELECCION':
            mensaje_notificacion = f'¡Felicidades! Has sido preseleccionado para "{postulacion.vacante.titulo}".'
        elif estado == 'CONTRATADO':
            mensaje_notificacion = f'¡Felicidades! Has sido contratado para "{postulacion.vacante.titulo}". ¡Bienvenido al equipo!'
        elif estado == 'RECHAZADO':
            mensaje_notificacion = f'Tu postulación para "{postulacion.vacante.titulo}" no fue seleccionada en esta ocasión.'
        elif estado == 'PENDIENTE':
            mensaje_notificacion = f'El estado de tu postulación para "{postulacion.vacante.titulo}" ha cambiado a Pendiente.'
        
        if mensaje_notificacion:
            Notificacion.objects.create(
                usuario=postulacion.candidato.user,
                titulo=f'Cambio de estado en tu postulación',
                mensaje=mensaje_notificacion,
                tipo='CAMBIO_ESTADO',
                url=f'/mis-postulaciones/'
            )
        
        messages.success(request, f'Postulación actualizada a {postulacion.get_estado_display()} exitosamente.')
    else:
        messages.error(request, 'Estado no válido.')
    
    return redirect('postulaciones_vacante', vacante_id=postulacion.vacante.id)


@login_required
def perfil_candidato_editar(request):
    """
    Permite al candidato editar su perfil.
    """
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'candidato':
            messages.error(request, 'Solo los candidatos pueden acceder a esta página.')
            return redirect('inicio')
        
        candidato = request.user.candidato
    except (Perfil.DoesNotExist, Candidato.DoesNotExist):
        messages.error(request, 'Debes completar tu perfil.')
        return redirect('inicio')
    
    if request.method == 'POST':
        candidato.telefono = request.POST.get('telefono', candidato.telefono)
        candidato.direccion = request.POST.get('direccion', candidato.direccion)
        candidato.experiencia = request.POST.get('experiencia', candidato.experiencia)
        candidato.dui = request.POST.get('dui', candidato.dui)
        candidato.area_interes = request.POST.get('area_interes', candidato.area_interes)
        candidato.estudios = request.POST.get('estudios', candidato.estudios)
        candidato.habilidades = request.POST.get('habilidades', candidato.habilidades)
        
        # Actualizar categorías de interés
        categorias_ids = request.POST.getlist('categorias_interes')
        candidato.categorias_interes.set(Categoria.objects.filter(id__in=categorias_ids))
        
        # Actualizar información del usuario
        request.user.first_name = request.POST.get('first_name', request.user.first_name)
        request.user.email = request.POST.get('email', request.user.email)
        request.user.save()
        
        candidato.save()
        messages.success(request, '¡Perfil actualizado exitosamente!')
        return redirect('perfil_candidato_editar')
    
    # Obtener todas las categorías para el formulario
    categorias = Categoria.objects.all()
    
    return render(request, 'empleos/perfil_candidato_editar.html', {
        'candidato': candidato,
        'categorias': categorias,
    })


@login_required
def perfil_candidato(request, candidato_id):
    """
    Vista completa del perfil de un candidato (para Empresas).
    """
    # Verificar que el usuario sea una empresa
    try:
        perfil_usuario = request.user.perfil
        if perfil_usuario.tipo_usuario != 'empresa':
            messages.error(request, 'Solo las empresas pueden ver perfiles de candidatos.')
            return redirect('inicio')
    except Perfil.DoesNotExist:
        messages.error(request, 'No tienes permiso para ver este perfil.')
        return redirect('inicio')
    
    candidato = get_object_or_404(Candidato.objects.select_related('user'), pk=candidato_id)
    
    return render(request, 'empleos/perfil_candidato.html', {
        'candidato': candidato,
    })


@login_required
def mis_postulaciones(request):
    """
    Mostrar las postulaciones del candidato logueado.
    """
    try:
        perfil = request.user.perfil
        if perfil.tipo_usuario != 'candidato':
            messages.error(request, 'Solo los candidatos pueden ver sus postulaciones.')
            return redirect('inicio')
        
        candidato = request.user.candidato
    except (Perfil.DoesNotExist, Candidato.DoesNotExist):
        messages.error(request, 'Debes completar tu perfil.')
        return redirect('inicio')
    
    postulaciones = Postulacion.objects.filter(candidato=candidato).select_related('vacante__empresa', 'vacante__categoria').order_by('-fecha_postulacion')
    
    return render(request, 'empleos/mis_postulaciones.html', {
        'postulaciones': postulaciones,
    })


@login_required
def notificaciones(request):
    """
    Mostrar las notificaciones del usuario.
    """
    notificaciones = Notificacion.objects.filter(usuario=request.user)
    no_leidas = notificaciones.filter(leida=False).count()
    
    return render(request, 'empleos/notificaciones.html', {
        'notificaciones': notificaciones,
        'no_leidas': no_leidas,
    })


@login_required
def marcar_notificacion_leida(request, notificacion_id):
    """
    Marcar una notificación como leída.
    """
    notificacion = get_object_or_404(Notificacion, pk=notificacion_id, usuario=request.user)
    notificacion.marcar_como_leida()
    
    if notificacion.url:
        return redirect(notificacion.url)
    return redirect('notificaciones')


@login_required
def marcar_todas_leidas(request):
    """
    Marcar todas las notificaciones como leídas.
    """
    Notificacion.objects.filter(usuario=request.user, leida=False).update(leida=True)
    messages.success(request, 'Todas las notificaciones han sido marcadas como leídas.')
    return redirect('notificaciones')


# =========================
# ADMIN VIEWS
# =========================

def is_admin(user):
    """Check if user is admin (superuser or staff)."""
    return user.is_superuser or user.is_staff


@login_required
def admin_panel(request):
    """
    Panel de administración principal.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para acceder al panel de administración.')
        return redirect('inicio')
    
    from django.db.models import Count, Q
    
    # Estadísticas
    total_usuarios = User.objects.count()
    total_candidatos = Candidato.objects.count()
    total_empresas = Empresa.objects.count()
    total_vacantes = Vacante.objects.count()
    total_postulaciones = Postulacion.objects.count()
    total_categorias = Categoria.objects.count()
    
    # Últimos usuarios registrados
    ultimos_usuarios = User.objects.order_by('-date_joined')[:10]
    
    # Empresas con cantidad de vacantes (ordenadas de mayor a menor)
    empresas_con_vacantes = Empresa.objects.annotate(
        num_vacantes=Count('vacante')
    ).order_by('-num_vacantes')
    
    # Áreas (categorías) con más ofertas de empleo activas
    areas_con_vacantes = Categoria.objects.annotate(
        num_vacantes=Count('vacante', filter=Q(vacante__estado='ACTIVA'))
    ).order_by('-num_vacantes')
    
    # Máximo de vacantes para escalar el gráfico
    max_vacantes_area = areas_con_vacantes[0].num_vacantes if areas_con_vacantes and areas_con_vacantes[0].num_vacantes > 0 else 1
    
    return render(request, 'empleos/admin/panel.html', {
        'total_usuarios': total_usuarios,
        'total_candidatos': total_candidatos,
        'total_empresas': total_empresas,
        'total_vacantes': total_vacantes,
        'total_postulaciones': total_postulaciones,
        'total_categorias': total_categorias,
        'ultimos_usuarios': ultimos_usuarios,
        'empresas_con_vacantes': empresas_con_vacantes,
        'areas_con_vacantes': areas_con_vacantes,
        'max_vacantes_area': max_vacantes_area,
    })


@login_required
def admin_usuarios(request):
    """
    Administrar todos los usuarios.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para acceder.')
        return redirect('inicio')
    
    usuarios = User.objects.all().order_by('-date_joined')
    return render(request, 'empleos/admin/usuarios.html', {'usuarios': usuarios})


@login_required
def admin_eliminar_usuario(request, user_id):
    """
    Eliminar un usuario (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    usuario = get_object_or_404(User, pk=user_id)
    
    if usuario == request.user:
        messages.error(request, 'No puedes eliminar tu propia cuenta.')
        return redirect('admin_usuarios')
    
    if request.method == 'POST':
        username = usuario.username
        usuario.delete()
        messages.success(request, f'Usuario "{username}" eliminado exitosamente.')
        return redirect('admin_usuarios')
    
    return render(request, 'empleos/admin/confirmar_eliminar_usuario.html', {'usuario': usuario})


@login_required
def admin_empresas(request):
    """
    Administrar todas las empresas.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para acceder.')
        return redirect('inicio')
    
    empresas = Empresa.objects.all()
    return render(request, 'empleos/admin/empresas.html', {'empresas': empresas})


@login_required
def admin_vacantes(request):
    """
    Administrar todas las vacantes.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para acceder.')
        return redirect('inicio')
    
    vacantes = Vacante.objects.all().select_related('empresa', 'categoria').order_by('-fecha_publicacion')
    return render(request, 'empleos/admin/vacantes.html', {'vacantes': vacantes})


@login_required
def admin_eliminar_vacante(request, vacante_id):
    """
    Eliminar cualquier vacante (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    if request.method == 'POST':
        titulo = vacante.titulo
        vacante.delete()
        messages.success(request, f'Vacante "{titulo}" eliminada exitosamente.')
        return redirect('admin_vacantes')
    
    return render(request, 'empleos/admin/confirmar_eliminar_vacante.html', {'vacante': vacante})


@login_required
def admin_categorias(request):
    """
    Administrar categorías.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para acceder.')
        return redirect('inicio')
    
    categorias = Categoria.objects.all()
    return render(request, 'empleos/admin/categorias.html', {'categorias': categorias})


@login_required
def admin_crear_categoria(request):
    """
    Crear nueva categoría.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    if request.method == 'POST':
        nombre = request.POST.get('nombre')
        if nombre:
            Categoria.objects.create(nombre=nombre)
            messages.success(request, f'Categoría "{nombre}" creada exitosamente.')
            return redirect('admin_categorias')
        else:
            messages.error(request, 'El nombre es requerido.')
    
    return render(request, 'empleos/admin/crear_categoria.html')


@login_required
def admin_eliminar_categoria(request, categoria_id):
    """
    Eliminar una categoría (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    categoria = get_object_or_404(Categoria, pk=categoria_id)
    
    if request.method == 'POST':
        nombre = categoria.nombre
        categoria.delete()
        messages.success(request, f'Categoría "{nombre}" eliminada exitosamente.')
        return redirect('admin_categorias')
    
    return render(request, 'empleos/admin/confirmar_eliminar_categoria.html', {'categoria': categoria})


@login_required
def admin_editar_usuario(request, user_id):
    """
    Editar un usuario (solo admin). Permite cambiar nombre, email, estado activo y staff.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    usuario = get_object_or_404(User, pk=user_id)
    
    if request.method == 'POST':
        usuario.first_name = request.POST.get('first_name', usuario.first_name)
        usuario.email = request.POST.get('email', usuario.email)
        usuario.is_active = request.POST.get('is_active') == 'on'
        
        # Only superusers can toggle staff status
        if request.user.is_superuser:
            usuario.is_staff = request.POST.get('is_staff') == 'on'
        
        usuario.save()
        messages.success(request, f'Usuario "{usuario.username}" actualizado exitosamente.')
        return redirect('admin_usuarios')
    
    return render(request, 'empleos/admin/editar_usuario.html', {'usuario': usuario})


@login_required
def admin_editar_empresa(request, empresa_id):
    """
    Editar una empresa (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    empresa = get_object_or_404(Empresa, pk=empresa_id)
    
    if request.method == 'POST':
        empresa.nombre = request.POST.get('nombre', empresa.nombre)
        empresa.correo = request.POST.get('correo', empresa.correo)
        empresa.telefono = request.POST.get('telefono', empresa.telefono)
        empresa.direccion = request.POST.get('direccion', empresa.direccion)
        empresa.sector = request.POST.get('sector', empresa.sector)
        empresa.descripcion = request.POST.get('descripcion', empresa.descripcion)
        empresa.persona_contacto = request.POST.get('persona_contacto', empresa.persona_contacto)
        empresa.sitio_web = request.POST.get('sitio_web', empresa.sitio_web)
        empresa.save()
        messages.success(request, f'Empresa "{empresa.nombre}" actualizada exitosamente.')
        return redirect('admin_empresas')
    
    return render(request, 'empleos/admin/editar_empresa.html', {'empresa': empresa})


@login_required
def admin_eliminar_empresa(request, empresa_id):
    """
    Eliminar una empresa (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    empresa = get_object_or_404(Empresa, pk=empresa_id)
    
    if request.method == 'POST':
        nombre = empresa.nombre
        empresa.delete()
        messages.success(request, f'Empresa "{nombre}" eliminada exitosamente.')
        return redirect('admin_empresas')
    
    return render(request, 'empleos/admin/confirmar_eliminar_empresa.html', {'empresa': empresa})


@login_required
def admin_editar_vacante(request, vacante_id):
    """
    Editar una vacante (solo admin). No requiere ser la empresa propietaria.
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    categorias = Categoria.objects.all()
    
    if request.method == 'POST':
        vacante.titulo = request.POST.get('titulo', vacante.titulo)
        vacante.ubicacion = request.POST.get('ubicacion', vacante.ubicacion)
        vacante.descripcion = request.POST.get('descripcion', vacante.descripcion)
        vacante.requisitos = request.POST.get('requisitos', vacante.requisitos)
        vacante.experiencia = request.POST.get('experiencia', vacante.experiencia)
        vacante.nivel_experiencia = request.POST.get('nivel_experiencia', vacante.nivel_experiencia)
        vacante.fecha_limite = request.POST.get('fecha_limite', vacante.fecha_limite)
        vacante.tipo_contrato = request.POST.get('tipo_contrato', vacante.tipo_contrato)
        vacante.estado = request.POST.get('estado', vacante.estado)
        
        # Sanitización de salario
        salario = request.POST.get('salario')
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
            try:
                vacante.salario = float(salario)
            except ValueError:
                vacante.salario = None
        else:
            vacante.salario = None
        
        # Sanitización de numero_vacantes
        try:
            vacante.numero_vacantes = int(request.POST.get('numero_vacantes', vacante.numero_vacantes))
            if vacante.numero_vacantes < 1:
                vacante.numero_vacantes = 1
        except (ValueError, TypeError):
            pass
        
        # Categoría
        categoria_id = request.POST.get('categoria')
        if categoria_id:
            vacante.categoria = Categoria.objects.get(id=categoria_id)
        else:
            vacante.categoria = None
        
        vacante.save()
        messages.success(request, f'Vacante "{vacante.titulo}" actualizada exitosamente.')
        return redirect('admin_vacantes')
    
    return render(request, 'empleos/admin/editar_vacante.html', {
        'vacante': vacante,
        'categorias': categorias,
    })


@login_required
def admin_toggle_vacante_estado(request, vacante_id):
    """
    Alternar el estado de una vacante entre ACTIVA y CERRADA (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    vacante = get_object_or_404(Vacante, pk=vacante_id)
    
    if request.method == 'POST':
        nuevo_estado = request.POST.get('estado', '')
        if nuevo_estado in ['ACTIVA', 'CERRADA']:
            vacante.estado = nuevo_estado
            vacante.save()
            estado_display = 'Activa' if nuevo_estado == 'ACTIVA' else 'Cerrada'
            messages.success(request, f'Vacante "{vacante.titulo}" cambiada a {estado_display}.')
        else:
            # Toggle if no specific state provided
            vacante.estado = 'CERRADA' if vacante.estado == 'ACTIVA' else 'ACTIVA'
            vacante.save()
            estado_display = 'Activa' if vacante.estado == 'ACTIVA' else 'Cerrada'
            messages.success(request, f'Vacante "{vacante.titulo}" cambiada a {estado_display}.')
    
    return redirect('admin_vacantes')


@login_required
def admin_editar_categoria(request, categoria_id):
    """
    Editar una categoría (solo admin).
    """
    if not is_admin(request.user):
        messages.error(request, 'No tienes permiso para realizar esta acción.')
        return redirect('inicio')
    
    categoria = get_object_or_404(Categoria, pk=categoria_id)
    
    if request.method == 'POST':
        nombre = request.POST.get('nombre', '').strip()
        if nombre:
            categoria.nombre = nombre
            categoria.save()
            messages.success(request, f'Categoría actualizada a "{nombre}" exitosamente.')
            return redirect('admin_categorias')
        else:
            messages.error(request, 'El nombre es requerido.')
    
    return render(request, 'empleos/admin/editar_categoria.html', {'categoria': categoria})

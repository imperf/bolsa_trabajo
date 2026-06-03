from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.core.exceptions import PermissionDenied
from .models import Vacante, Empresa, Categoria, Perfil, Candidato, Postulacion


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
        usuario_o_correo = request.POST.get('email') 
        clave = request.POST.get('password')
        
        # Autenticar con Django auth
        user = authenticate(request, username=usuario_o_correo, password=clave)
        
        if user is not None:
            login(request, user)
            
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
    # Obtener vacantes activas para el dashboard
    vacantes = Vacante.objects.filter(estado='ACTIVA').select_related('empresa')
    return render(request, 'empleos/dashboard.html', {'vacantes': vacantes})


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
        Vacante.objects.create(
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
    estados_validos = ['PENDIENTE', 'EN_REVISION', 'PRESELECCION', 'ACEPTADO', 'RECHAZADO']
    if estado in estados_validos:
        postulacion.estado = estado
        postulacion.save()
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
        
        # Actualizar información del usuario
        request.user.first_name = request.POST.get('first_name', request.user.first_name)
        request.user.email = request.POST.get('email', request.user.email)
        request.user.save()
        
        candidato.save()
        messages.success(request, '¡Perfil actualizado exitosamente!')
        return redirect('perfil_candidato_editar')
    
    return render(request, 'empleos/perfil_candidato_editar.html', {
        'candidato': candidato,
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

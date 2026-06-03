from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.contrib.auth.decorators import login_required
from .models import Vacante, Empresa, Categoria, Perfil


def inicio(request):
    return render(request, 'empleos/inicio.html')


def lista_empleos(request):
    # Obtener vacantes activas usando el ORM de Django
    vacantes = Vacante.objects.filter(estado='ACTIVA').select_related('empresa', 'categoria')
    return render(
        request,
        'empleos/lista_empleos.html',
        {
            'vacantes': vacantes
        }
    )


def detalle_empleo(request):
    return render(request, 'empleos/detalle_empleo.html')


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

            # ⚠️ Estos campos existen en el formulario pero NO están en el modelo Django actual:
            dui = request.POST.get('dui', '')
            estudios = request.POST.get('estudios', '')
            habilidades = request.POST.get('habilidades', '')
            area_interes = request.POST.get('area_interes', '')

            print(f"[DEBUG-CANDIDATO] DUI={dui}, Estudios={estudios}, Habilidades={habilidades}, AreaInteres={area_interes}")

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

            # Crear candidato (solo campos existentes en el modelo)
            Candidato.objects.create(
                user=user,
                telefono=telefono,
                direccion='',  # placeholder, se puede editar después
                experiencia=experiencia
            )

        elif tipo == 'empresa':
            nombre_empresa = request.POST.get('nombre_empresa')
            direccion = request.POST.get('direccion_empresa', '')
            telefono = request.POST.get('telefono_empresa')
            correo = request.POST.get('email_empresa')

            # ⚠️ Estos campos existen en el formulario pero NO están en el modelo Django actual:
            sector = request.POST.get('sector', '')
            persona_contacto = request.POST.get('persona_contacto', '')

            print(f"[DEBUG-EMPRESA] Sector={sector}, Contacto={persona_contacto}")

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

            # Crear empresa (solo campos existentes en el modelo)
            Empresa.objects.create(
                nombre=nombre_empresa,
                descripcion='',
                direccion=direccion,
                telefono=telefono,
                correo=correo
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
    if request.method == 'POST':
        titulo = request.POST.get('titulo')
        ubicacion = request.POST.get('ubicacion')
        categoria_id = request.POST.get('categoria')
        salario = request.POST.get('salario')
        descripcion = request.POST.get('descripcion')
        fecha_limite = request.POST.get('fecha_limite')

        # Sanitización de salarios
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
            try:
                salario = float(salario)
            except ValueError:
                salario = None
        else:
            salario = None

        categoria_obj = Categoria.objects.get(id=categoria_id) if categoria_id else None
        
        # Obtener primera empresa (o asignar según el perfil)
        empresa = Empresa.objects.first()
        if not empresa:
            # Crear una empresa por defecto si no existe
            empresa = Empresa.objects.create(
                nombre="Empresa Default",
                descripcion="Empresa registrada en el sistema",
                direccion="Sin dirección",
                telefono="0000-0000",
                correo="empresa@example.com"
            )

        # Crear vacante usando el ORM de Django
        Vacante.objects.create(
            titulo=titulo,
            empresa=empresa,
            ubicacion=ubicacion,
            categoria=categoria_obj,
            salario=salario,
            descripcion=descripcion,
            fecha_limite=fecha_limite
        )
            
        return redirect('lista_empleos')

    # Obtener categorías para el formulario
    categorias = Categoria.objects.all()
    
    return render(request, 'empleos/publicar_empleo.html', {
        'categorias': categorias
    })
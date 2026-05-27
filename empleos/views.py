
from django.shortcuts import render, redirect  # Agregamos redirect
from django.contrib.auth.models import User    # Agregamos el modelo User
from django.contrib.auth import authenticate, login
from django.shortcuts import render
from .models import Vacante
from .models import Empresa
from .models import Perfil
from .models import Categoria
from .models import Roles
from django.db import connection
with connection.cursor() as cursor:
    cursor.callproc('sp_reporte_vacantes_empresa', [1])

def inicio(request):
    return render(request, 'empleos/inicio.html')


def lista_empleos(request):

    vacantes = Vacante.objects.all()

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
    # Traemos todos los registros de la tabla Empresa de tu MySQL80
    lista_de_empresas = Empresa.objects.all()
    
    return render(
        request, 
        'empleos/empresas.html', 
        {
            'empresas': lista_de_empresas  # Enviamos los datos al HTML
        }
    )



def login_view(request):
    if request.method == 'POST':
        # 1. Obtenemos los datos. En Django, por defecto se autentica con 'username'.
        
        usuario_o_correo = request.POST.get('email') 
        clave = request.POST.get('password')
        
        # 2. Autenticación
        user = authenticate(request, username=usuario_o_correo, password=clave)
        
        if user is not None:
            login(request, user)
            
            # 3. Redirección basada en el Perfil 
            # Usamos un bloque try/except por si el usuario no tiene perfil aún
            try:
                if user.perfil.tipo_usuario == 'empresa':
                    return redirect('dashboard') # Nombre corregido según tus urlpatterns
                else:
                    return redirect('inicio')
            except AttributeError:
                # Si el usuario existe en auth_user pero no tiene perfil
                return redirect('inicio')
        else:
            # 4. Manejo de error de credenciales
            return render(request, 'empleos/login.html', {
                'error': 'Usuario o contraseña incorrectos',
                'datos': request.POST # Para no borrar lo que el usuario escribió
            })
            
    return render(request, 'empleos/login.html')
def registro(request):
    lista_roles = Roles.objects.all()
    if request.method == 'POST':
        nombre_completo = request.POST.get('nombre')
        usuario = request.POST.get('usuario')
        correo = request.POST.get('email')
        clave = request.POST.get('password')
        tipo = request.POST.get('tipo_usuario')
        
        # 1. Crear el usuario base
        user = User.objects.create_user(
            username=usuario, 
            email=correo, 
            password=clave,
            first_name=nombre_completo
        )
        
        # 2. Crear el Perfil 
        Perfil.objects.create(usuario=user, tipo_usuario=tipo)
        
        # 3. NUEVO: Crear la instancia de Empresa si el tipo es empresa
        if tipo == 'empresa':
            Empresa.objects.create(
                usuario=user, 
                nombre_empresa=nombre_completo # O el nombre que gustes por defecto
                # Puedes agregar más campos por defecto aquí
            )
        
        return redirect('login')
        
    return render(request, 'empleos/registro.html', {
        'roles': lista_roles
    })

def dashboard(request):
    return render(request, 'empleos/dashboard.html')


def publicar_empleo(request):
    if request.method == 'POST':
        titulo = request.POST.get('titulo')
        ubicacion = request.POST.get('ubicacion')
        categoria_id = request.POST.get('categoria')
        salario = request.POST.get('salario')
        descripcion = request.POST.get('descripcion')
        fecha_limite = request.POST.get('fecha_limite')

        # Buscar instancias correspondientes en la Base de Datos
        categoria_instancia = Categoria.objects.get(pk=categoria_id) if categoria_id else None
        
        # Buscar la primera empresa registrada por defecto o enlazar a la correspondiente
        empresa_instancia = Empresa.objects.first()

        # Limpiar el salario si viene con texto o vacío
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
        else:
            salario = None

        # Guardar directamente en la base de datos de MySQL
        Vacante.objects.create(
            titulo=titulo,
            ubicacion=ubicacion,
            categoria=categoria_instancia,
            empresa=empresa_instancia,
            salario=salario,
            descripcion=descripcion,
            requisitos='No especificados',
            estado='ACTIVA',
            fecha_limite=fecha_limite
        )
        return redirect('lista_empleos')

    # Obtenemos todas las categorías guardadas
    categorias = Categoria.objects.all()
    
    return render(request, 'empleos/publicar_empleo.html', {
        'categorias': categorias
    })


from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login
from django.db import connection

# Función auxiliar para transformar los resultados de tuplas a diccionarios compatibles con las plantillas HTML
def dictfetchall(cursor):
    "Retorna todas las filas de un cursor como un diccionario"
    columns = [col[0] for col in cursor.description]
    return [dict(zip(columns, row)) for row in cursor.fetchall()]


def inicio(request):
    return render(request, 'empleos/inicio.html')


def lista_empleos(request):
    # Regla de BD: Se lee directamente desde la VISTA de MySQL
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM vw_vacantes_disponibles")
        vacantes = dictfetchall(cursor)

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
    # Consulta Directa SQL a la tabla Empresa
    with connection.cursor() as cursor:
        cursor.execute("SELECT * FROM empleos_empresa")
        lista_de_empresas = dictfetchall(cursor)
    
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
        
        # El login requiere verificar la sesión del lado del servidor de aplicaciones
        user = authenticate(request, username=usuario_o_correo, password=clave)
        
        if user is not None:
            login(request, user)
            
            try:
                if user.perfil.tipo_usuario == 'empresa':
                    return redirect('dashboard')
                else:
                    return redirect('inicio')
            except AttributeError:
                return redirect('inicio')
        else:
            return render(request, 'empleos/login.html', {
                'error': 'Usuario o contraseña incorrectos',
                'datos': request.POST
            })
            
    return render(request, 'empleos/login.html')


def registro(request):
    # Consulta cruda para cargar el catálogo de roles directamente de la tabla 'roles'
    with connection.cursor() as cursor:
        cursor.execute("SELECT idrol, descripcion FROM roles")
        lista_roles = dictfetchall(cursor)

    if request.method == 'POST':
        nombre_completo = request.POST.get('nombre')
        usuario = request.POST.get('usuario')
        correo = request.POST.get('email')
        clave = request.POST.get('password')
        tipo = request.POST.get('tipo_usuario')
        idrol = request.POST.get('Idrol')
        
        # Regla de BD: Se envía todo a tu procedimiento almacenado transaccional de MySQL
        with connection.cursor() as cursor:
            cursor.callproc('sp_registrar_usuario', [usuario, correo, clave, nombre_completo, tipo, idrol])
        
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

        # Sanitización de salarios para la inserción limpia en MySQL
        if salario:
            salario = salario.replace('$', '').replace(',', '').strip()
            try:
                salario = float(salario)
            except ValueError:
                salario = None
        else:
            salario = None

        categoria_id = int(categoria_id) if categoria_id else None

        # Regla de BD: Guardar llamando de forma directa a tu procedimiento 'sp_publicar_vacante'
        with connection.cursor() as cursor:
            cursor.callproc('sp_publicar_vacante', [titulo, ubicacion, categoria_id, salario, descripcion, fecha_limite])
            
        return redirect('lista_empleos')

    # Obtener categorías usando SQL puro para renderizar el formulario select
    with connection.cursor() as cursor:
        cursor.execute("SELECT id, nombre FROM empleos_categoria")
        categorias = dictfetchall(cursor)
    
    return render(request, 'empleos/publicar_empleo.html', {
        'categorias': categorias
    })
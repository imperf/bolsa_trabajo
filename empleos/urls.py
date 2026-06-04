from django.urls import path
from django.contrib.auth import views as auth_views
from . import views

urlpatterns = [
    path('', views.inicio, name='inicio'),
    path('empleos/', views.lista_empleos, name='lista_empleos'),
    path('empleo/<int:vacante_id>/', views.detalle_empleo, name='detalle_empleo'),
    path('empleo/<int:vacante_id>/postular/', views.postular_empleo, name='postular_empleo'),
    path('empresas/', views.empresas, name='empresas'),
    path('login/', views.login_view, name='login'),
    path('registro/', views.registro, name='registro'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('publicar/', views.publicar_empleo, name='publicar_empleo'),
    path('mis-empleos/', views.mis_empleos, name='mis_empleos'),
    path('empleo/<int:vacante_id>/postulaciones/', views.postulaciones_vacante, name='postulaciones_vacante'),
    path('postulacion/<int:postulacion_id>/estado/<str:estado>/', views.actualizar_estado_postulacion, name='actualizar_estado_postulacion'),
    path('perfil/', views.perfil_candidato_editar, name='perfil_candidato_editar'),
    path('mis-postulaciones/', views.mis_postulaciones, name='mis_postulaciones'),
    path('candidato/<int:candidato_id>/', views.perfil_candidato, name='perfil_candidato'),
    path('empleo/editar/<int:vacante_id>/', views.editar_empleo, name='editar_empleo'),
    path('empleo/eliminar/<int:vacante_id>/', views.eliminar_empleo, name='eliminar_empleo'),
    path('notificaciones/', views.notificaciones, name='notificaciones'),
    path('notificacion/<int:notificacion_id>/leer/', views.marcar_notificacion_leida, name='marcar_notificacion_leida'),
    path('notificaciones/marcar-todas/', views.marcar_todas_leidas, name='marcar_todas_leidas'),
    # Admin URLs
    path('admin-panel/', views.admin_panel, name='admin_panel'),
    path('admin/usuarios/', views.admin_usuarios, name='admin_usuarios'),
    path('admin/eliminar-usuario/<int:user_id>/', views.admin_eliminar_usuario, name='admin_eliminar_usuario'),
    path('admin/empresas/', views.admin_empresas, name='admin_empresas'),
    path('admin/vacantes/', views.admin_vacantes, name='admin_vacantes'),
    path('admin/eliminar-vacante/<int:vacante_id>/', views.admin_eliminar_vacante, name='admin_eliminar_vacante'),
    path('admin/categorias/', views.admin_categorias, name='admin_categorias'),
    path('admin/crear-categoria/', views.admin_crear_categoria, name='admin_crear_categoria'),
    path('admin/eliminar-categoria/<int:categoria_id>/', views.admin_eliminar_categoria, name='admin_eliminar_categoria'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
]

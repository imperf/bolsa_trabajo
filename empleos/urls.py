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
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
]

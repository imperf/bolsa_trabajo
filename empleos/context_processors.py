from .models import Notificacion

def notificaciones_context(request):
    """
    Context processor to add unread notification count to all templates.
    """
    if request.user.is_authenticated:
        no_leidas = Notificacion.objects.filter(usuario=request.user, leida=False).count()
        return {'notificaciones_no_leidas': no_leidas}
    return {'notificaciones_no_leidas': 0}
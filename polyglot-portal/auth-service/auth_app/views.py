"""Views for auth_app."""
from django.http import JsonResponse
from django.views import View


def auth_status(request):
    """Return authentication service status."""
    return JsonResponse({
        'service': 'auth-service',
        'status': 'ok',
        'version': '1.0.0',
    })


def health_check(request):
    """Health check endpoint for container health probes."""
    return JsonResponse({
        'status': 'healthy',
        'service': 'auth-service',
    })
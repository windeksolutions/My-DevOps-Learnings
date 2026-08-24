"""URL patterns for auth API."""
from django.urls import path
from . import views

urlpatterns = [
    path('status', views.auth_status, name='auth-status'),
    path('health', views.health_check, name='health-check'),
]
from django.urls import path

from .consumers import DetectData

ws_urlpatterns = [
    path('ws/detectData', DetectData.as_asgi()),
]
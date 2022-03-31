from django.urls import path

from .consumers import DetectData
from .consumers import Test1

ws_urlpatterns = [
    path('ws/detectData', DetectData.as_asgi()),
    path('ws/testing', Test1.as_asgi())
]
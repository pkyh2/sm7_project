from django.contrib import admin
from django.urls import path
from api import views
from django.conf.urls import include

urlpatterns = [
    path('accounts', views.account_list),
    path('accounts/<int:pk>', views.account),
    path('login', views.login),
    path('auth', include('rest_framework.urls', namespace='rest_framework'))
]
from django.urls import path
from motorartigos.views import index,artigo,detalhe_comercio,mostrar_dashboard

urlpatterns = [
    path('',index,name='index'),
    path('artigo/',artigo,name='artigo'),
    path('artigo/<int:id>/', detalhe_comercio, name='detalhe_comercio'),
    path('dashboard/', mostrar_dashboard, name='mostrar_dashboard'),
 ]
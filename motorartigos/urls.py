from django.urls import path
from motorartigos.views import index,artigo,detalhe_comercio

urlpatterns = [
    path('',index,name='index'),
    path('artigo/',artigo,name='artigo'),
    path('artigo/<int:id>/', detalhe_comercio, name='detalhe_comercio'),
 ]
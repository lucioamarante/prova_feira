from django.urls import path
from motorartigos.views import index,artigo,detalhe_artigo

urlpatterns = [
    path('',index,name='index'),
    path('artigo/',artigo,name='artigo'),
    path('artigo/<int:id>/', detalhe_artigo, name='detalhe_artigo'),
 ]
from django.shortcuts import render
#from django.http import HttpResponse
from motorartigos.models import Autor,Artigo
from django.db.models import Q # Importante para buscas complexas

def index(request):
    # Todos os artigos para a seção "Todos os Artigos"
    artigos_todos = Artigo.objects.filter(publicada=True)
    
    # Apenas os 4 últimos para a seção "Mais recentes"
    artigos_recentes = Artigo.objects.filter(publicada=True).order_by('-data_publicacao')[:4]
    # Captura o termo de busca vindo do input name="busca"
    termo_busca = request.GET.get('busca')
    if termo_busca:
        # Filtra título, conteúdo, nome do autor ou nome do eixo
        artigos_todos = artigos_todos.filter(
            Q(titulo__icontains=termo_busca) | 
            Q(texto__icontains=termo_busca) |
            Q(id_fk_autor__nome__icontains=termo_busca) |
            Q(id_fk_eixo__nome__icontains=termo_busca)
        )

    contexto = {
        'artigos': artigos_todos,
        'artigos_recentes': artigos_recentes
    }
    return render(request, 'motorartigos/index.html', contexto)

def artigo(request):
    return render(request,'motorartigos/artigo.html')
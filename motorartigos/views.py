from django.shortcuts import render, get_object_or_404
#from django.http import HttpResponse
from motorartigos.models import Responsavel,Artigo,EixoTecnologia
from django.db.models import Q # Importante para buscas complexas


def index(request):
    artigos_base = Artigo.objects.filter(publicada=True)
    
    # CORREÇÃO AQUI: Busca diretamente da tabela de eixos. 
    # Assim, virão apenas os 3 eixos cadastrados, sem duplicar!
    eixos = EixoTecnologia.objects.all()

    termo_busca = request.GET.get('busca')
    eixo_id = request.GET.get('eixo')

    artigos_todos = artigos_base

    # Se clicou em um eixo específico, filtra por ele
    if eixo_id:
        artigos_todos = artigos_todos.filter(id_fk_eixo__id=eixo_id)

    # Se digitou algo na barra de pesquisa
    if termo_busca:
        artigos_todos = artigos_todos.filter(
            Q(titulo__icontains=termo_busca) | 
            Q(texto__icontains=termo_busca) |
            Q(id_fk_autor__nome__icontains=termo_busca) |
            Q(id_fk_eixo__nome__icontains=termo_busca)
        )
    
    artigos_recentes = artigos_base.order_by('-data_publicacao')[:4]

    contexto = {
        'artigos': artigos_todos,
        'artigos_recentes': artigos_recentes,
        'eixos': eixos,                           
        'eixo_selecionado': eixo_id,               
        'termo_busca': termo_busca                 
    }
    return render(request, 'motorartigos/index.html', contexto)

def artigo(request):
    return render(request,'motorartigos/artigo.html')

def detalhe_artigo(request, id):
    artigo = get_object_or_404(
        Artigo.objects.select_related('id_fk_eixo', 'id_fk_responsavel'),
        id=id,
        publicada=True
    )
    return render(request, 'motorartigos/banca.html', {'artigo': artigo})
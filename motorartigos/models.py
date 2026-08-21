from django.db import models
from tinymce.models import HTMLField
from django.urls import reverse


class Responsavel(models.Model):
    nome = models.CharField(max_length=100, verbose_name='Nome')
    biografia = models.TextField(verbose_name='Biografia')
    email = models.EmailField(verbose_name='E-mail')

    def __str__(self):
        return self.nome

    class Meta:
        db_table = 'responsavel'
        verbose_name = 'Responsável'
        verbose_name_plural = 'Responsáveis'


class EixoTecnologia(models.Model):
    nome = models.CharField(max_length=60, verbose_name='Nome')

    def __str__(self):
        return self.nome

    class Meta:
        db_table = 'eixo'
        verbose_name = 'Eixo de Tecnologia'
        verbose_name_plural = 'Eixos de Tecnologia'


class Comercio(models.Model):

    titulo = models.CharField(        
        max_length=200,
        verbose_name='Título',
        default='Sem título'
    )
    foto = models.ImageField(upload_to="fotos/%Y/%m/%d/", blank=True)
    publicada = models.BooleanField(default=False)
    TAG_NIVEL = [
        ("bo", "box"),
        ("ru", "rua"),
        ("mi", "minishopping"),
        ("ga", "galpão"),
        ("lo", "loja de fachada"),
        ("gal", "galeria de rua"),
        ("ba", "banca"),
        ("co", "corredor"),
        ("ca", "calçada"),
    ]

    nivel = models.CharField(
        max_length=3,
        choices=TAG_NIVEL,
        default='bo',            
        verbose_name='Nível'
    )
    texto = HTMLField(verbose_name='Texto')
    data_publicacao = models.DateTimeField(
        auto_now_add=True,
        verbose_name='Data de Publicação'
    )
    id_fk_eixo = models.ForeignKey(
        EixoTecnologia,
        on_delete=models.CASCADE,
        db_column='id_fk_eixo',
        verbose_name='Eixo',        
        related_name='artigos'
    )
    id_fk_responsavel = models.ForeignKey(
        Responsavel,
        on_delete=models.CASCADE,
        db_column='id_fk_responsavel',
        verbose_name='Responsável',       
        related_name='artigos'
    )

    def __str__(self):
        return f"Artigo {self.id} – {self.id_fk_responsavel.nome}"  # 👈 mais legível

    class Meta:
        db_table = 'comercio'
        verbose_name = 'Comercio'
        verbose_name_plural = 'Comercios'
        ordering = ['-data_publicacao']  
    # Adicione este método dentro da classe Artigo no seu models.py:
    def get_absolute_url(self):
       return reverse('detalhe_artigo', args=[self.id])

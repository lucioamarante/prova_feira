-- banco de dados para gerar artigos em um blog
-- DDL (Criar (D) Definition)
CREATE DATABASE motorartigos;
USE motorartigos;
SHOW TABLES;
CREATE TABLE eixo(
   id INT PRIMARY KEY auto_increment,
   nome VARCHAR(70) NOT NULL
);
-- DML
INSERT INTO eixo(nome)VALUES('python');
INSERT INTO eixo(nome)VALUES('matemática');
INSERT INTO eixo(nome)VALUES('estatística');
INSERT INTO eixo(nome)VALUES('pandas');
INSERT INTO eixo(nome)VALUES('machine learning');
INSERT INTO eixo(nome)VALUES('django');
-- DQL
SELECT * FROM eixo WHERE id = 3;
CREATE TABLE autor(
   id INT PRIMARY KEY auto_increment,
   nome VARCHAR(100) NOT NULL,
   perfil TEXT NOT NULL
);
INSERT INTO autor(nome,perfil)values('Israel','Jovem jovem');
INSERT INTO autor(nome,perfil)values('Luiz','Ultra jovem');
INSERT INTO autor(nome,perfil)values('Lucas','Nada Jovem');
INSERT INTO autor(nome,perfil)values('Pedro','Super Jovem');
INSERT INTO autor(nome,perfil)values('Josué','Jovem Forte');
INSERT INTO autor(nome,perfil)values('Andre 2','Jovem sempre');

CREATE TABLE artigo(
   id INT PRIMARY KEY auto_increment,
   texto LONGTEXT NOT NULL,
   data_publicacao DATETIME NOT NULL,
   id_fk_eixo INT NOT NULL,
   id_fk_autor INT NOT NULL,
   foreign key(id_fk_eixo) REFERENCES eixo(id),
   foreign key(id_fk_autor) REFERENCES autor(id)  
);

INSERT INTO artigo (texto, data_publicacao, id_fk_eixo, id_fk_autor) VALUES 
-- Eixo 1: Python
('Como funcionam os Decorators em Python? Decorators são uma ferramenta poderosa que permite modificar o comportamento de uma função ou classe. Eles são amplamente utilizados em frameworks web para checagem de autenticação e rotas.', '2026-01-10 09:00:00', 1, 1),
('Gerenciamento de memória no Python: Entendendo o Garbage Collector. Ao contrário do C, o Python gerencia a memória automaticamente usando contagem de referências e um coletor de lixo geracional para lidar com referências circulares.', '2026-01-15 14:00:00', 1, 3),
('Ambientes Virtuais: Venv vs Conda. Isolar as dependências dos seus projetos é a regra número um do desenvolvimento Python. Enquanto o venv é nativo e leve, o conda gerencia pacotes binários complexos essenciais para Data Science.', '2026-02-05 10:30:00', 1, 6),

-- Eixo 2: Matemática
('Álgebra Linear para Inteligência Artificial: Por onde começar. Vetores, matrizes e transformações lineares formam o coração dos algoritmos de Deep Learning. Entender o produto escalar é o primeiro passo para compreender como as redes neurais processam dados.', '2026-02-12 08:45:00', 2, 2),
('O papel do Cálculo Diferencial na otimização de modelos. O algoritmo de Gradient Descent, usado para treinar modelos, depende inteiramente de derivadas parciais para descobrir a direção que minimiza a função de custo (erro) do modelo.', '2026-02-20 11:15:00', 2, 1),
('Matrizes e Redução de Dimensionalidade. Operações com matrizes, como a Decomposição em Valores Singulares (SVD), são a base matemática de algoritmos de compressão de dados como o PCA (Principal Component Analysis).', '2026-03-01 16:20:00', 2, 5),

-- Eixo 3: Estatística
('Teste de Hipóteses na prática com Testes A/B. Ao lançar uma nova funcionalidade, como sabemos se o aumento nas vendas foi real ou apenas sorte? Testes de hipóteses e p-values nos dão a confiança matemática para tomar essas decisões.', '2026-03-10 13:00:00', 3, 3),
('Compreendendo a Regressão Linear Simples. A regressão linear tenta traçar a melhor linha reta através de um conjunto de pontos. É a introdução perfeita à modelagem preditiva, ajudando a entender a correlação entre duas variáveis.', '2026-03-18 09:30:00', 3, 4),
('O que é a Distribuição Binomial? Usada para modelar o número de sucessos em uma sequência de tentativas independentes (como jogar uma moeda ou clicar em um anúncio), a distribuição binomial é essencial para a análise de conversão.', '2026-04-02 15:45:00', 3, 6),

-- Eixo 4: Pandas
('Groupby vs Pivot Table no Pandas: Qual escolher? Ambas as funções agregam dados, mas a pivot_table é ideal para criar visualizações cruzadas em formato de matriz, enquanto o groupby é mais rápido e versátil para manipulações em pipeline.', '2026-04-10 10:00:00', 4, 4),
('Melhores práticas para lidar com valores nulos (NaN) no Pandas. O método fillna() permite substituir nulos por médias ou valores fixos, enquanto dropna() limpa os registros incompletos. A escolha errada pode introduzir viés nas suas análises.', '2026-04-15 14:20:00', 4, 5),
('Otimização de memória com o método astype(). Ao carregar um CSV, o Pandas usa tipos de dados que consomem muita memória, como float64. Converter colunas categóricas para o tipo "category" e reduzir inteiros para int8 pode economizar até 80% de RAM.', '2026-04-22 11:00:00', 4, 1),

-- Eixo 5: Machine Learning
('Random Forest vs XGBoost: A batalha dos algoritmos de árvore. Enquanto o Random Forest constrói dezenas de árvores independentes (bagging), o XGBoost constrói árvores sequenciais, onde cada nova árvore corrige os erros das anteriores (boosting).', '2026-05-05 09:10:00', 5, 5),
('Clusterização de clientes com o algoritmo K-Means. O K-Means é um modelo de aprendizado não-supervisionado que agrupa dados baseados na distância entre eles. É amplamente usado pelo marketing para criar personas de consumidores de forma automatizada.', '2026-05-12 16:30:00', 5, 6),
('Introdução às Redes Neurais Convolucionais (CNNs). Inspiradas no córtex visual animal, as CNNs utilizam filtros de convolução para identificar bordas, texturas e padrões em imagens, revolucionando a área de Visão Computacional.', '2026-05-18 10:45:00', 5, 2),
('MLOps: Como colocar seu modelo de Machine Learning em produção. Treinar o modelo no Jupyter Notebook é fácil, o desafio real é criar APIs escaláveis usando Docker e monitorar o data drift para garantir que o modelo continue preciso com o passar do tempo.', '2026-05-25 13:15:00', 5, 3),

-- Eixo 6: Django
('Criando Middlewares personalizados no Django. Os middlewares interceptam as requisições antes de chegarem à view e as respostas antes de voltarem ao usuário. São perfeitos para implementar logs customizados, bloqueio de IPs ou injeção de cabeçalhos.', '2026-06-01 15:00:00', 6, 6),
('Autenticação JWT com Django REST Framework. Os tokens JSON Web (JWT) são o padrão da indústria para criar APIs seguras e sem estado (stateless), permitindo que aplicações frontend como React e Vue consumam seus dados de forma autenticada.', '2026-06-08 08:30:00', 6, 1),
('Tarefas em background no Django utilizando Celery e Redis. Nunca faça o usuário esperar por um processamento pesado, como envio de e-mails em massa ou geração de relatórios PDF. Aprenda a delegar essas tarefas para workers assíncronos usando o Celery.', '2026-06-15 14:00:00', 6, 4),
('Sinais (Signals) no Django: Cuidados e Boas Práticas. Signals são ótimos para desacoplar lógicas, como criar um perfil de usuário automaticamente após o registro. Mas o uso excessivo pode tornar o fluxo da aplicação confuso e difícil de debugar.', '2026-06-20 11:30:00', 6, 2);
-- SEM INTELIGÊNCIA ARTIFICIAL (tente criar dois join ARTIGO join EIXO join AUTOR
CREATE VIEW view_detalhes_artigos AS
SELECT 
    ar.id AS id_artigo,
    ar.texto AS conteudo_artigo,
    DATE_FORMAT(ar.data_publicacao, '%d/%m/%Y') AS Data_Publicacao,
    ex.nome AS nome_eixo,
    au.nome AS nome_autor,
    au.perfil AS perfil_autor
FROM 
    artigo ar
INNER JOIN 
    eixo ex ON ar.id_fk_eixo = ex.id
INNER JOIN 
    autor au ON ar.id_fk_autor = au.id;
    
SELECT * FROM view_detalhes_artigos;
    
-- PROCEDURE

-- 1. Mudamos o delimitador padrão (;) para ($$) temporariamente.
-- Isso evita que o banco encerre a criação da procedure no primeiro ponto e vírgula que encontrar lá dentro.
DELIMITER $$

CREATE PROCEDURE BuscarArtigosPorCategoria(IN nome_categoria VARCHAR(70))
BEGIN
    -- 2. Aqui dentro vai a nossa instrução SQL.
    -- Vamos usar a VIEW que criamos anteriormente para manter o código limpo.
    SELECT 
        id_artigo, 
        nome_autor, 
        data_publicacao, 
        conteudo_artigo
    FROM 
        view_detalhes_artigos
    WHERE 
        nome_eixo = nome_categoria;

END $$

-- 3. Voltamos o delimitador para o padrão (ponto e vírgula)
DELIMITER ;


-- Buscar todos os artigos sobre Python
CALL BuscarArtigosPorCategoria('python');

-- Buscar todos os artigos sobre Machine Learning
CALL BuscarArtigosPorCategoria('machine learning');
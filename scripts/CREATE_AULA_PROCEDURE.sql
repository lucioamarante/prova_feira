USE motorartigos;

-- STORED 01
-- 1. Mudamos o delimitador para não conflitar 
-- com o ponto e vírgula interno
DELIMITER $$
-- 2. Criamos a procedure sem parâmetros de entrada (os parênteses ficam vazios)
CREATE PROCEDURE alo_mundo()
BEGIN
    -- 3. Um SELECT simples que apenas retorna um texto fixo
    SELECT 'Hello World! Procedure!' AS Mensagem;
END $$
-- 4. Voltamos o delimitador para o padrão
DELIMITER ;
CALL alo_mundo();

DELIMITER $$
CREATE PROCEDURE pesquisa_artigos_ok(IN nome_eixo VARCHAR(60))
BEGIN		
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
			autor au ON ar.id_fk_autor = au.id
		WHERE ex.nome = nome_eixo;
END $$
-- 4. Voltamos o delimitador para o padrão
DELIMITER ;
CALL pesquisa_artigos_ok('Python');



-- muda o delimitador para nao conflitar com o ponto e virgula interno
DELIMITER $$

CREATE PROCEDURE pesquisa_artigo_2(IN eixo VARCHAR(60))
BEGIN	
	SELECT * 
    	FROM view_detalhes_artigos
	WHERE nome_eixo = eixo;
END $$

-- volta o delimitador para o padrao
DELIMITER ;

DROP PROCEDURE pesquisa_artigo_2;
CALL pesquisa_artigo_2('Python');



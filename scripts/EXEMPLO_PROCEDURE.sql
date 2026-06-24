
USE motorartigos;

-- STORED 01
-- 1. Mudamos o delimitador para não conflitar com o ponto e vírgula interno

DELIMITER $$

-- 2. Criamos a procedure sem parâmetros de entrada (os parênteses ficam vazios)
CREATE PROCEDURE AloMundo()
BEGIN
    -- 3. Um SELECT simples que apenas retorna um texto fixo
    SELECT 'Olá, Mundo! Bem-vindos ao universo das Stored Procedures no MySQL!' AS Mensagem;
END $$

-- 4. Voltamos o delimitador para o padrão
DELIMITER ;
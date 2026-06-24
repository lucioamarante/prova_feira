/*
    Relembre seu ensino fundamental
    Como é o algoritmo de calcular se um valor é par ou impar
    Qual a função?
    3 minutos...
*/


DELIMITER $$

CREATE FUNCTION VerificaParImpar(numero INT) 
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE resultado VARCHAR(10);
    
    -- O operador % pega o resto da divisão por 2
    IF numero % 2 = 0 THEN
        SET resultado = 'Par';
    ELSE
        SET resultado = 'Ímpar';
    END IF;
    
    RETURN resultado;
END$$

DELIMITER ;



SELECT VerificaParImpar(10); -- Retorna: Par
SELECT VerificaParImpar(7);  -- Retorna: Ímpar


DELIMITER $$

CREATE PROCEDURE VerificaParImparProc(IN numero INT)
BEGIN
    -- Verifica se o resto da divisão por 2 é zero
    IF numero % 2 = 0 THEN
        SELECT 'Par' AS Resultado;
    ELSE
        SELECT 'Ímpar' AS Resultado;
    END IF;
END$$

DELIMITER ;


CALL VerificaParImparProc(10); 
-- Vai exibir uma tabela com a coluna "Resultado" e o valor "Par"

CALL VerificaParImparProc(7);  
-- Vai exibir uma tabela com a coluna "Resultado" e o valor "Ímpar"



-- Módulo
-- Resto da Divisão = 0 então é par senão é impar

DELIMITER $$
CREATE PROCEDURE VerificaParProc(IN numero INT)
BEGIN
     IF numero % 2 = 0 THEN
          SELECT 'Par' AS Resultado;
          ELSE
          SELECT 'Impar' AS Resultado;
	 END IF;
END $$
DELIMITER ;

-- ETL (Extract, Transform ou Load)
/*
  Extract (extrai) - pegar os dados de uma tabela bruta.
 
  Transform (Transforma) - limpa os dados (padroniza os dados),calcular totais
  
  Load (Carrega) - Inserir os dados limpos tabela final (relatório)
  View ,Excel .. Dashboardetc..
  
  * Update na própria tabela
  * Insert em uma nova tabela
  * Procedure gere um View a partir do Transform
  * (Brasal) Procedure pegou os dados de ERP gerou .txt (galera do Excel importar)
  * (Aneel) PL SQL (oracle) com ciência de dados. 
  * SQL (MySQL)   -- TSQL (SQL Server) --- PL SQL (Oracle)
*/

/* Criando o Cenário para ETL */

/* Dados Brutos */ 
/*  vendas_brutas */
DROP DATABASE demo_etl;
CREATE DATABASE demo_etl;
USE demo_etl;
CREATE TABLE vendas_brutas(   
   id INT primary key auto_increment,
   produto VARCHAR(100),
   quantidade INT,
   preco_unitario DECIMAL(10,2),
   data_venda DATE
);
/* Destino - Dados pronto para um DataWareHouse / BI */
CREATE TABLE fato_vendas(
   id INT PRIMARY KEY auto_increment,
   produto_formatado VARCHAR(100),
   quantidade INT,
   preco_unitario DECIMAL(10,2),
   valor_total DECIMAL(10,2), -- calculado o TRANSFORM
   data_venda DATE,
   data_processamento timestamp default current_timestamp
);
INSERT INTO vendas_brutas(produto,
           quantidade,
           preco_unitario,
           data_venda)VALUES('   notebook dell   ',2,3500.00,'2026-06-20'),
                             ('  MoUsE oPTiCO',2,3500.00,'2026-06-20');
SELECT * FROM vendas_brutas;

-- Criar a procedure de ETL
DELIMITER $$

CREATE PROCEDURE sp_executar_etl_vendas()
BEGIN
     -- [Declaração de Variáveis
     DECLARE v_id INT;
     DECLARE v_produto VARCHAR(100);
     DECLARE  v_quantidade INT;
     DECLARE v_preco DECIMAL(10,2);
     DECLARE v_data DATE;
	 -- Como controlar o fim?
     DECLARE fim_do_cursor INT DEFAULT FALSE;
     
     -- [E] EXTRACT :Declarando o curso para extrair os dados da origem
     DECLARE cursor_vendas CURSOR FOR
          SELECT id,produto,quantidade,preco_unitario,data_venda FROM vendas_brutas;
	 -- Tratamento para quando o cursor chegar no fim do registro
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim_do_cursor = TRUE;
     -- Abrindo o cursor
     OPEN cursor_vendas;
     -- Loop para processar cada linha
     read_loop:LOOP
        -- Extrair a linha atual e jogar nas variáveis
        FETCH cursor_vendas INTO v_id,v_produto,v_quantidade,v_preco,v_data;
        
        -- Se não houver mais linhas, sai do loop
        IF fim_do_cursor THEN
           LEAVE read_loop;
		END IF;
        
        -- [T] - Transform & [LOAD]:
        -- Tratar o Texto (TRIM( ), UPPER)
        -- Valor Total (preco * quantidade)
        INSERT INTO fato_vendas(id,
                                produto_formatado,
                                quantidade,
                                preco_unitario,
                                valor_total,data_venda)
                                VALUES(
                                  v_id,
                                  UPPER(TRIM(v_produto)),
                                  v_quantidade,
                                  v_preco,
                                  (v_quantidade * v_preco),
                                   v_data
                                   );
                                
							
     END LOOP;
     -- Fechando o cursor
     CLOSE cursor_vendas;
     -- Mensagem de sucesso
     SELECT 'Processo ETL finalizado com sucesso' AS Status;	
     
END $$

DELIMITER ;

CALL sp_executar_etl_vendas();
SELECT * FROM fato_vendas;
















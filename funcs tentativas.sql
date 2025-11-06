SET search_path TO bd053_schema, public;

-- SELECT * from periodico;

DROP PROCEDURE IF EXISTS adicionar_periodico(
	IN nome_publicacao character varying,
    IN nome_antigo VARCHAR,
	IN periodicidade character varying) ;

CREATE OR REPLACE PROCEDURE adicionar_periodico( 
    nome_publicacao VARCHAR,
    periodicidade IN VARCHAR DEFAULT '', 
    nome_antigo IN VARCHAR DEFAULT '' 
    )  

AS 
$mudar_periodico$ 
DECLARE a_atualizar BOOLEAN; 
BEGIN
    a_atualizar = FALSE; -- Zero se não atualizar o nome

    IF nome_antigo = '' THEN 
       a_atualizar = TRUE;
       nome_antigo = nome_publicacao;	 
    END IF; 

    IF nome_publicacao IS NULL THEN 
       RAISE EXCEPTION 'O nome da publicação não pode ser NULL'; 
    END IF; 

    IF nome_antigo IN (SELECT nome FROM periodico) THEN 

        UPDATE periodico  
        SET nome = nome_publicacao, periodicidade = periodicidade   
        WHERE nome = nome_antigo;

        UPDATE periodicidade  
        SET nome_publicacao = nome_publicacao, periodicidade = periodicidade
        WHERE nome_publicacao = nome_antigo;

    ELSE 
        -- se a_atualizar = 1 entao tentou e falhou em dar update no nome
        IF NOT a_atualizar THEN 
            INSERT INTO periodico(nome,periodicidade) VALUES (nome_publicacao,periodicidade); 
        ELSE 
            RAISE EXCEPTION 'O nome antigo não está na base de dados'; 
        END IF; 
    END IF; 
    END;
$mudar_periodico$
LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE atualizar_multas( 
    data_atual DATE
    )  
AS 
$atualizar_multas$ 
-- ver os empréstimos e adicionar a multa aqueles que passaram do prazo, 
-- rever os valores das multas atuais (0.5 euro/dia)
DECLARE valor_por_dia NUMERIC;
BEGIN
valor_por_dia = 0.5;
    INSERT INTO multar(emprestimo_id,data_emprestimo,prazo_limite,email ) 
     (SELECT emprestimo_id,data_emprestimo,prazo_retorno,email FROM emprestar_utilizador WHERE prazo_retorno < data_atual AND emprestimo_id NOT IN (SELECT emprestimo_id FROM multar)); 

UPDATE multar
SET valor =  LEAST( ROUND(( data_atual - data_emprestimo  )  * valor_por_dia, 2), 99999.99 );   
END;
$atualizar_multas$
LANGUAGE plpgsql;


--CALL adicionar_periodico('a',NULL,'b');
--select * from periodico;
--DELETE FROM periodico;


/*
CREATE OR REPLACE PROCEDURE adicionar_user tambem atualiza
CREATE OR REPLACE PROCEDURE adicionar_multa
CREATE OR REPLACE PROCEDURE agendar_sala
CREATE OR REPLACE PROCEDURE adicionar_autor
CREATE OR REPLACE PROCEDURE avaliar_livro
CREATE OR REPLACE PROCEDURE acessar_livro
CREATE OR REPLACE PROCEDURE emprestar_livro
CREATE OR REPLACE PROCEDURE reservar_livro
CREATE OR REPLACE PROCEDURE adicionar_fisico
CREATE OR REPLACE PROCEDURE adicionar_digital
*/

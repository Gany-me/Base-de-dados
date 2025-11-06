SET search_path TO bd053_schema, public;

CREATE OR REPLACE PROCEDURE adicionar_livro( 
    nome_livro VARCHAR, 
    mensagem OUT VARCHAR, 
    genero IN VARCHAR DEFAULT '', 
    n_paginas IN NUMERIC DEFAULT 0,
    descricao IN VARCHAR DEFAULT '',
    data_publicacao IN DATE DEFAULT '0001-12-30',
    lingua IN VARCHAR DEFAULT 'portugues',
    nome_antigo IN VARCHAR DEFAULT '' 
    )  
AS 
$livro$ 
<<livro>>
DECLARE a_atualizar INT; 
BEGIN
    a_atualizar = 1; -- Zero se não atualizar livro
    mensagem = 'sucesso'; 

    IF nome_livro IS NULL THEN 
        RAISE EXCEPTION 'O nome do livro não pode ser NULL'; 
        EXIT adicionar_livro;
    END IF; 

    IF nome_antigo = '' THEN 
       a_atualizar = 0;
       nome_antigo = nome_livro;	 
    END IF;

    IF nome_antigo IN (SELECT nome FROM periodico) THEN 

        UPDATE periodico CASCADE
        SET nome = nome_publicacao, periodicidade = periodicidade   
        WHERE nome = nome_antigo;

        UPDATE periodicidade CASCADE
        SET nome_publicacao = nome_publicacao, periodicidade = periodicidade   
        WHERE nome_publicacao = nome_antigo;

    ELSE 
        -- se a_atualizar = 1 entao tentou e falhou em dar update no nome
        IF a_atualizar = 0 THEN 
            INSERT INTO periodico(nome,periodicidade) VALUES (nome_publicacao,periodicidade); 
        ELSE 
            mensagem = 'insucesso'; 
        END IF; 
    END IF; 
    END;
$livro$
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

CREATE OR REPLACE PROCEDURE pro( 
    data_atual DATE
    )  
AS 
$pro$ 
-- ver os empréstimos e adicionar a multa aqueles que passaram do prazo e rever os valores das multas atuais (0.5 euro/dia)
BEGIN
 SELECT * FROM emprestimos;
END;
$pro$
LANGUAGE plpgsql;

DELETE FROM emprestimo;
DELETE FROM utilizador;
DELETE FROM emprestar_utilizador;

--INSERT INTO emprestimo(data_emprestimo,prazo_retorno) VALUES ('January 08, 2005','February 14, 2005');
--INSERT INTO utilizador(email,password) VALUES ('abc@tuacota.pt','#ya_03');
--INSERT INTO emprestar_utilizador(email,emprestimo_id, data_emprestimo,prazo_retorno) VALUES ('abc@tuacota.pt',1,'January 08, 2005','February 14, 2005');

-- SELECT * from multar;

CALL atualizar_multas(CURRENT_DATE);
SELECT * from multar;
--SELECT emprestimo_id,data_emprestimo,prazo_retorno,email FROM emprestar_utilizador;
--SELECT * from periodico;
--DELETE FROM periodico;

DROP PROCEDURE IF EXISTS  adicionar_livro(
	IN nome_livro character varying,
	OUT mensagem character varying,
	IN genero VARCHAR ,
	IN n_paginas numeric ,
	IN descricao VARCHAR ,
	IN data_publicacao date,
	IN lingua VARCHAR ,
	IN nome_antigo VARCHAR);
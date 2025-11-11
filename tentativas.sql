SET search_path TO bd053_schema, public;


--select * from course;

DROP TABLE IF EXISTS test;
DROP FUNCTION IF EXISTS test_;
/*
CREATE TABLE test(
    id_ SERIAL PRIMARY KEY,
    numero NUMERIC(1,0),
    palavra text
);
*/
-- INSERT INTO test(palavra,numero) VALUES ('a',3),('C',4);

--SELECT * from test WHERE id_ BETWEEN 2 and 2 AND numero BETWEEN 3 AND 3;


CREATE OR REPLACE PROCEDURE test_( IN id text, IN nome text, mensagem OUT TEXT) 
AS $test$
DECLARE mensagem TEXT;
BEGIN
 	IF (id, nome) IS NULL THEN 
        SET mensagem = 'SIM';
    ELSE 
        SET mensagem = 'NAO';
    END IF;
  END; 
$test$
LANGUAGE plpgsql; 

DROP PROCEDURE IF EXISTS test_(IN nome text,OUT mensagem text);
DROP PROCEDURE IF EXISTS test_( IN id text, IN nome text, mensagem OUT TEXT) ;

DROP FUNCTION test_(text,text);


CREATE OR REPLACE FUNCTION test_( nome text , mensagem TEXT) 
--RETURNS TABLE( ids_inusados INT )
RETURNS INTEGER ARRAY
AS $test$
DECLARE id_maximo INT;
DECLARE primeiro BOOLEAN;
DECLARE entidade_ids INT ARRAY;
DECLARE ids_inusados INT ARRAY;
BEGIN
	IF nome = 'emprestimo' THEN
		entidade_ids = ARRAY(SELECT id FROM bd053_schema.emprestimo ORDER BY id ASC);
  IF nome = 'livro' THEN
  IF nome = 'utilizador' THEN
  END IF;

	id_maximo = entidade_ids[ array_length(entidade_ids,1) ];
  primeiro = TRUE;

	FOR id_atual IN 1..id_maximo LOOP
		
		if NOT (id_atual = ANY(entidade_ids)) THEN

      IF primeiro THEN
        ids_inusados[1] = id_atual;
        primeiro = FALSE;
      ELSE
			  ids_inusados = array_append(ids_inusados, id_atual);
      END IF;

		END IF;
	END LOOP;

  RETURN ids_inusados;
END; 
$test$
LANGUAGE plpgsql;

SELECT * FROM test_('emprestimo',NULL);
SELECT * FROM ids_inusados('emprestimo');

SELECT * from bd053_schema.emprestimo;

SELECT COUNT(id) from bd053_schema.emprestimo;
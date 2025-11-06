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

CREATE OR REPLACE PROCEDURE test_( in nome text , OUT mensagem TEXT) 
 LANGUAGE plpgsql
AS $test$
BEGIN
 	IF nome IS NULL THEN 
        mensagem = 'SIM';
    ELSE 
        mensagem = 'NAO';
    END IF;
  END; 
$test$;
 


CALL test_(NULL,NULL);

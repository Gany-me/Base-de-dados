SET search_path TO bd053_schema, public;

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
    INSERT INTO multar(emprestimo_id,data_emprestimo,prazo_limite,id_aluno ) 
     (SELECT emprestimo_id,data_emprestimo,prazo_retorno,id_aluno 
     FROM emprestar_utilizador NATURAL JOIN emprestimo
      WHERE prazo_retorno < data_atual 
      AND emprestimo_id NOT IN (SELECT emprestimo_id FROM multar) AND ativo); 

UPDATE multar
SET valor =  LEAST( ROUND(( data_atual - data_emprestimo  )  * valor_por_dia, 2), 99999.99 )
WHERE estado = 'por pagar';   
END;
$atualizar_multas$
LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS atividade_livros_user();

CREATE OR REPLACE FUNCTION atividade_livros_user()  
RETURNS TABLE(
	id_aluno INT,
	n_emprestimos BIGINT,
	n_acessos BIGINT,
	n_reservas_livros BIGINT,
	n_reservas_salas BIGINT
)
AS 
$pro$ 
BEGIN
RETURN QUERY
	SELECT T1.id_aluno, n_emprestimos, n_acessos, n_reservas
	FROM (select todo.id_aluno, COUNT(emprestimo_id) as n_emprestimos 
		FROM ( select id as id_aluno FROM utilizador) as todo
		LEFT OUTER JOIN ( select id_aluno,emprestimo_id FROM emprestar_utilizador) as emp
		ON todo.id_aluno = emp.id_aluno
		GROUP BY todo.id_aluno) as T1
	NATURAL JOIN ( select ace.id_aluno,n_acessos,n_reservas 
					FROM ( select id as id_aluno, COUNT(tempo_acesso) as n_acessos FROM utilizador
						LEFT OUTER JOIN (select id_aluno,tempo_acesso from acesso) as T3
						ON utilizador.id = T3.id_aluno
						GROUP BY utilizador.id) as ace
					NATURAL JOIN ( select T5.id_aluno,COUNT(reserva_id) as n_reservas FROM ( select id as id_aluno FROM utilizador) as T5
						LEFT OUTER JOIN ( select id_aluno,reserva_id FROM reserva_utilizador) as T4
						ON T5.id_aluno = T4.id_aluno
						GROUP BY T5.id_aluno) as res) ;
END;
$pro$
LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION autor_avaliacao(autor VARCHAR)  
RETURNS TABLE(
	avaliacao_autor NUMERIC(2,1)
)
AS 
$$ 
-- retorna a avaliacao media dada ao autor
BEGIN

RETURN QUERY
	SELECT ROUND(SUM(avaliacao_tot) / SUM(n_avaliacoes) , 2) as avaliacao_autor -- assumindo que 1- todos os autores tem livro e 2- iremos contar as notas de livros nao avaliados (0)
	FROM (SELECT livro_id as id, nome_autor FROM autoria) NATURAL JOIN (SELECT id,avaliacao * n_avaliacoes as avaliacao_tot,n_avaliacoes FROM livro) as l
	WHERE nome_autor = autor
	GROUP BY nome_autor
	HAVING SUM(n_avaliacoes) > 0;

END;
$$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION ids_inusados(entidade TEXT)  
RETURNS INTEGER ARRAY
AS $ids_inusados$
DECLARE id_maximo INT;
DECLARE primeiro BOOLEAN;
DECLARE entidade_ids INT ARRAY;
DECLARE ids_inusados INT ARRAY;
BEGIN
	IF entidade = 'emprestimo' THEN
		entidade_ids = ARRAY(SELECT id FROM bd053_schema.emprestimo ORDER BY id ASC);
	ELSE
		IF entidade = 'livro' THEN
			entidade_ids = ARRAY(SELECT id FROM bd053_schema.livro ORDER BY id ASC);
		ELSE
			IF entidade = 'utilizador' THEN
				entidade_ids = ARRAY(SELECT id FROM bd053_schema.utilizador ORDER BY id ASC);
			ELSE
				RAISE EXCEPTION 'O nome da entidade tem de ser: emprestimo, utilizador, livro.';
			END IF;
		END IF;
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
$ids_inusados$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION recomendar_livro(id_utilizador INT)  
RETURNS VARCHAR
AS $recomendar_livro$
DECLARE livros_possiveis VARCHAR ARRAY;
DECLARE livros_escolhido VARCHAR;
BEGIN
	IF NOT (id_utilizador IN ( SELECT id_aluno FROM emprestar_utilizador)) AND NOT (id_utilizador IN ( SELECT id_aluno FROM reserva_utilizador)) AND NOT (id_utilizador IN ( SELECT id_aluno FROM livro_acessado)) THEN
		RAISE EXCEPTION 'utilizador nao tem historico de uso para a recomendacao ou nao existe utilizador com o id dado';
	END IF;

	livros_possiveis = ARRAY(SELECT titulo
							FROM livro
							WHERE genero IN ( SELECT genero FROM (SELECT * FROM emprestar_livro NATURAL JOIN emprestar_utilizador) as emprestimos INNER JOIN livro ON emprestimos.livro_id = livro.id WHERE id_aluno = id_utilizador) 
							OR  genero IN ( SELECT genero FROM (SELECT * FROM reserva_livro NATURAL JOIN reserva_utilizador) as reservas INNER JOIN livro ON reservas.livro_id = livro.id WHERE id_aluno = id_utilizador)
							OR genero IN ( SELECT genero FROM livro NATURAL JOIN livro_acessado WHERE id_aluno = id_utilizador)
							ORDER BY avaliacao DESC);
	
	RETURN livros_possiveis[ RANDOM()*2 + 1];
END;
$recomendar_livro$
LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE adicionar_emprestimo(
	id_aluno INT,
	data_emprestimo DATE, 
 	prazo_retorno DATE,
	biblioteca_id int,
	id_livro INT,
	ativo BOOLEAN,
	emprestimo_id INT
)  
AS 
$pro$ 
BEGIN
 	INSERT INTO emprestimo(id,data_emprestimo,prazo_retorno,ativo) VALUES
	(emprestimo_id,data_emprestimo,prazo_retorno,ativo);

	INSERT INTO emprestar_utilizador(id_aluno,data_emprestimo,prazo_retorno,emprestimo_id) VALUES
	(id_aluno,data_emprestimo,prazo_retorno,emprestimo_id);

	INSERT INTO emprestar_local(biblioteca_id,data_emprestimo,prazo_retorno,emprestimo_id) VALUES
	(biblioteca_id,data_emprestimo,prazo_retorno,emprestimo_id);

	INSERT INTO emprestar_livro(livro_id,data_emprestimo,prazo_retorno,emprestimo_id) VALUES
	(id_livro,data_emprestimo,prazo_retorno,emprestimo_id);
END;
$pro$
LANGUAGE plpgsql;

-- fim------------------------------------------------------------

CREATE OR REPLACE PROCEDURE adicionar_reserva(
	id_aluno INT,
	data_emprestimo DATE, 
 	prazo_retorno DATE,
	biblioteca_id int,
	id_livro INT,
	ativo BOOLEAN,
	emprestimo_id INT
)  
AS 
$pro$ 
BEGIN
 	INSERT INTO reserva(data_reserva,prazo_limite,ativo,id) VALUES
	(data_emprestimo,prazo_retorno,ativo,emprestimo_id);

	INSERT INTO reserva_utilizador(id_aluno,data_reserva,prazo_limite,reserva_id) VALUES
	(id_aluno,data_emprestimo,prazo_retorno,emprestimo_id);

	INSERT INTO reserva_local(biblioteca_id,data_reserva,prazo_limite,reserva_id) VALUES
	(biblioteca_id,data_emprestimo,prazo_retorno,emprestimo_id);

	INSERT INTO reserva_livro(livro_id,data_reserva,prazo_limite,reserva_id) VALUES
	(id_livro,data_emprestimo,prazo_retorno,emprestimo_id);
END;
$pro$
LANGUAGE plpgsql;

-- VIEWS --------------------------------------------------------------------- 

DROP VIEW IF EXISTS livros_disp_emprestar;
DROP VIEW IF EXISTS utilizadores_com_multas;
DROP VIEW IF EXISTS ids_inusados_principais;

CREATE VIEW livros_disp_emprestar AS
	SELECT livro_id, titulo, biblioteca_id, biblioteca.nome as biblioteca_nome
	FROM (SELECT livro_id, livro.titulo, biblioteca_id,local_livro.n_disp FROM local_livro INNER JOIN livro ON local_livro.livro_id = livro.id) as livros
	INNER JOIN biblioteca
	ON livros.biblioteca_id = biblioteca.id
	WHERE livros.n_disp > 1;

CREATE VIEW utilizadores_com_multas AS
	SELECT email, nome, prazo_limite
	FROM multar NATURAL JOIN utilizador
	WHERE estado = 'por pagar';

CREATE VIEW ids_inusados_principais AS
	SELECT *
	FROM (SELECT ids_inusados as livros_ids FROM ids_inusados('livro'))
	CROSS JOIN (SELECT * 
				FROM (SELECT ids_inusados as emprestimos_ids 
					FROM ids_inusados('emprestimo')) 
					CROSS JOIN (SELECT ids_inusados as utilizador_ids 
								FROM ids_inusados('utilizador')));

-- TRIGGERS -------------------------------------

DROP TRIGGER IF EXISTS adicionada_avaliacao ON avaliar;

CREATE OR REPLACE FUNCTION adicionar_avaliacao()  
RETURNS TRIGGER AS $$ 
-- media das avaliacoes, incluso as que já foram entretanto apagadas
DECLARE 
BEGIN
	UPDATE livro 
	SET avaliacao = ROUND( (avaliacao * n_avaliacoes + NEW.avaliacao) / (n_avaliacoes + 1) ,2)
	WHERE id = NEW.livro_id;
	UPDATE livro 
	SET n_avaliacoes = n_avaliacoes + 1
	WHERE id = NEW.livro_id;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER adicionada_avaliacao -- fazer versão caso o utilizador mude de opinião
    AFTER INSERT ON avaliar
	FOR EACH ROW
	EXECUTE FUNCTION adicionar_avaliacao();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ajustada_avaliacao ON avaliar;

CREATE OR REPLACE FUNCTION ajustar_avaliacao()  
RETURNS TRIGGER AS $$ 
-- media das avaliacoes, incluso as que já foram entretanto apagadas
DECLARE 
BEGIN
	UPDATE livro 
	SET avaliacao = ROUND( (avaliacao * n_avaliacoes - OLD.avaliacao + NEW.avaliacao) / (n_avaliacoes) ,2)
	WHERE id = NEW.livro_id;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER ajustada_avaliacao -- versão caso o utilizador mude de opinião
    AFTER UPDATE OF avaliacao ON avaliar
	FOR EACH ROW
	EXECUTE FUNCTION ajustar_avaliacao();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS aumento_acessos ON livro_acessado;

CREATE OR REPLACE FUNCTION aumentar_n_acessos()  
RETURNS TRIGGER AS $$  
BEGIN
	UPDATE digital 
	SET n_acessos = n_acessos + 1
	WHERE  id = NEW.id_livro;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER aumento_acessos
    AFTER INSERT ON livro_acessado
	FOR EACH ROW
	EXECUTE FUNCTION aumentar_n_acessos();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS verificacao_multas ON emprestar_utilizador; 

 

CREATE OR REPLACE FUNCTION verificar_multas()   
RETURNS TRIGGER AS $$  
BEGIN 
    DELETE FROM emprestimo 
	WHERE id_aluno in (select id_aluno FROM multar WHERE estado = 'por pagar') and emprestimo_id IN (SELECT emprestimo_id FROM NEW);
	RETURN NEW; 
END; 
$$ 
LANGUAGE plpgsql; 


CREATE TRIGGER verificacao_multas -- impedir emprestimo se possuir multa
    AFTER INSERT ON emprestar_utilizador
	FOR EACH ROW
	EXECUTE FUNCTION verificar_multas();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ajuste_reservas  ON reserva_utilizador; 

CREATE OR REPLACE FUNCTION ajustar_reservados()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE local_livro 
	SET n_reservadas = n_reservadas + 1,  n_disp = n_disp - 1 -- tirar disponivel e por 1 nos reservados
	WHERE biblioteca_id IN ( SELECT biblioteca_id FROM reserva_local WHERE reserva_id = NEW.id ) -- se está nesta biblioteca
	AND livro_id IN ( SELECT livro_id FROM reserva_livro NATURAL JOIN reserva WHERE reserva_id = NEW.id AND reserva.ativo); -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql; 

CREATE TRIGGER ajuste_reservas -- ajusta nº de livros reservados
    BEFORE INSERT ON reserva_utilizador
	FOR EACH ROW
	EXECUTE FUNCTION ajustar_reservados();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ajuste_emprestados  ON emprestar_local; 

CREATE OR REPLACE FUNCTION ajustar_emprestados()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE local_livro 
	SET n_emprestadas = n_emprestadas + 1,  n_disp = n_disp - 1 -- tirar disponivel e por 1 nos reservados
	WHERE biblioteca_id IN ( SELECT biblioteca_id FROM emprestar_local WHERE reserva_id = NEW.id ) -- se está nesta biblioteca
	AND livro_id IN ( SELECT livro_id FROM emprestar_livro NATURAL JOIN emprestimo WHERE reserva_id = NEW.id AND emprestimo.ativo); -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql; 

CREATE TRIGGER ajuste_emprestados
    AFTER INSERT ON emprestar_local
	FOR EACH ROW
	EXECUTE FUNCTION ajustar_emprestados();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ajuste_local_biblioteca  ON local_livro; 

CREATE OR REPLACE FUNCTION ajustar_local_biblioteca()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE fisico 
	SET Copias_emprestadas= Copias_emprestadas- OLD.n_emprestadas + NEW.n_emprestadas,
	 Copias_emprestadas= Copias_emprestadas- OLD.n_emprestadas + NEW.n_emprestadas; -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql; 

CREATE TRIGGER ajuste_local_biblioteca -- irá ajustar o total no fisico após 
    AFTER UPDATE OF n_disp,n_reservadas,n_emprestadas ON local_livro
	FOR EACH ROW
	EXECUTE FUNCTION ajustar_local_biblioteca();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS adicionado_livro_local  ON local_livro; 

CREATE OR REPLACE FUNCTION adicionar_livro_local()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE fisico 
	SET Copias_totais = Copias_totais + NEW.total_copias, Copias_reservadas = Copias_reservadas + NEW.n_reservadas , Copias_emprestadas = Copias_emprestadas + NEW.n_emprestadas
	WHERE fisico.id = NEW.livro_id; -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql; 

CREATE TRIGGER adicionado_livro_local -- irá ajustar o total no fisico após 
    AFTER INSERT ON local_livro
	FOR EACH ROW
	EXECUTE FUNCTION adicionar_livro_local();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS ajustado_livro_local  ON local_livro; 

CREATE OR REPLACE FUNCTION ajustar_livro_local()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE fisico 
	SET Copias_totais = Copias_totais - OLD.total_copias + NEW.total_copias
	WHERE fisico.id = NEW.livro_id; -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql; 

CREATE TRIGGER ajustado_livro_local -- irá ajustar o total no fisico após 
    AFTER UPDATE OF total_copias ON local_livro
	FOR EACH ROW
	EXECUTE FUNCTION ajustar_livro_local();

-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS restricao_emprestimo ON emprestimo; 

CREATE OR REPLACE FUNCTION restringir_emprestimo()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE emprestimo 
	SET prazo_retorno =  data_emprestimo + 14 -- tirar disponivel e por 1 nos reservados
	WHERE emprestimo.id = NEW.id AND (prazo_retorno - data_emprestimo < 15); -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER restricao_emprestimo -- só podem ser no max 14 dias cada renovacao
    AFTER INSERT ON emprestimo
	FOR EACH ROW
	EXECUTE FUNCTION restringir_emprestimo() ;


-- fim ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS restricao_renovacoes  ON emprestimo; 

CREATE OR REPLACE FUNCTION restringir_renovacoes()   
RETURNS TRIGGER AS $$  
BEGIN 
	UPDATE emprestimo 
	SET prazo_retorno =  data_emprestimo + 14 -- tirar disponivel e por 1 nos reservados
	WHERE emprestimo.id = NEW.id AND (NEW.prazo_retorno - OLD.prazo_retorno < 15); -- se livro é da reserva nova e a reserva for ativa
	RETURN NEW;
END; 
$$ 
LANGUAGE plpgsql;

CREATE TRIGGER restricao_renovacoes -- só podem ser no max 14 dias cada renovacao
    AFTER UPDATE OF prazo_retorno ON emprestimo
	FOR EACH ROW
	WHEN (OLD.prazo_retorno IS DISTINCT FROM NEW.prazo_retorno)
	EXECUTE FUNCTION restringir_renovacoes() ;

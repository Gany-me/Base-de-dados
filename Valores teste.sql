SET search_path TO bd053_schema, public;


DELETE FROM emprestimo;
DELETE FROM utilizador;
DELETE FROM emprestar_utilizador;

SELECT data_emprestimo FROM emprestimo;

INSERT INTO emprestimo(id,data_emprestimo,prazo_retorno) VALUES
(1,'January 08, 2005','February 14, 2005'),
(2,'January 20, 2005','February 15, 2005'),
(5,'January 10, 2005','February 16, 2005')
ON CONFLICT (id) DO NOTHING;

DELETE FROM

INSERT INTO utilizador(email,password) VALUES ('abc@tuacota.pt','#ya_03'),
('1abc@tuacota.pt','#ya_03'),
('2abc@tuacota.pt','#ya_03')
ON CONFLICT (email) DO NOTHING;


INSERT INTO emprestar_livro(emprestimo_id,livro_id, data_emprestimo,prazo_retorno) VALUES
(1,1,'January 08, 2005','February 14, 2005'),
(2,2,'January 20, 2005','February 15, 2005'),
(3,3,'January 10, 2005','February 16, 2005')
ON CONFLICT (emprestimo_id,livro_id) DO NOTHING;

INSERT INTO emprestar_utilizador(id_aluno,emprestimo_id, data_emprestimo,prazo_retorno) VALUES
(1,1,'January 08, 2005','February 14, 2005'),
(1,2,'January 20, 2005','February 15, 2005'),
(1,3,'January 10, 2005','February 16, 2005');

INSERT INTO livro(titulo,id,genero) VALUES 
('NULL',1,'a'),('1984',2,'b'),
('brave',3,'a'),('world',4,'b'),('testw',10,'c')
ON CONFLICT (id) DO NOTHING;

INSERT INTO biblioteca(id,nome) VALUES
(1,'FCUL'),(2,'FLUL');

INSERT INTO fisico(id_livro,Copias_totais) VALUES
(1,3),(2,5);

DELETE FROM local_livro;
INSERT INTO local_livro(livro_id,total_copias,n_disp,biblioteca_id) VALUES
(1,2,2,1),(2,3,3,2),(2,3,3,1);


INSERT INTO autor(nome,id) VALUES 
('WHOMST',1),('GEORGE',2),
('ALDEY',3),('HUXLEY',4)
ON CONFLICT (id) DO NOTHING;

INSERT INTO autoria(nome_autor,autor_id,livro_id) VALUES 
('WHOMST',1,1),('GEORGE',2,2),
('ALDEY',3,4),('HUXLEY',4,3);

INSERT INTO acesso(id_aluno, tempo_acesso) VALUES 
(2,CURRENT_TIMESTAMP),(2,CURRENT_DATE),
(3,CURRENT_TIMESTAMP);

INSERT INTO avaliar(id_aluno,livro_id,avaliacao) VALUES (1,1,3);
INSERT INTO avaliar(id_aluno,livro_id,avaliacao) VALUES (2,1,1.15),(2,2,3);

UPDATE avaliar SET avaliacao = 4 WHERE email = '1abc@tuacota.pt' AND livro_id = 1;

SELECT * from bd053_schema.livro  ;
SELECT * from avaliar  ;
SELECT * from autoria  ;
SELECT * from bd053_schema.emprestar_utilizador  ;
SELECT * from acesso  ;
SELECT * from emprestimo  ;

DELETE FROM avaliar;
DELETE FROM autoria;
DELETE FROM bd053_schema.emprestar_livro;
DELETE FROM emprestimo;
DELETE FROM livro;

SELECT * from recomendar_livro(1)  ;

SELECT * from autor_avaliacao('ALDEY')  ;

SELECT nome_autor, ROUND(SUM(avaliacao_tot) / SUM(n_avaliacoes) , 2) as avaliacao_autor -- assumindo que 1- todos os autores tem livro e 2- iremos contar as notas de livros nao avaliados (0)
	FROM (SELECT livro_id as id, nome_autor FROM autoria) NATURAL JOIN (SELECT id,avaliacao * n_avaliacoes as avaliacao_tot,n_avaliacoes FROM livro) as l
	WHERE nome_autor = 'WHOMST'
	GROUP BY nome_autor;

SELECT avaliacao * n_avaliacoes FROM livro;

select * from atividade_livros_user();

SELECT id_aluno, COUNT(emprestimo_id) as n_emprestimos, COUNT(tempo_acesso) as n_acessos, COUNT( reserva_id ) as n_reservas_livros, COUNT( Data_reserva ) as n_reservas_salas
	FROM emprestar_utilizador FULL OUTER JOIN (SELECT * FROM acesso NATURAL JOIN ( SELECT * FROM  agendar NATURAL JOIN reserva_utilizador))
	GROUP BY id_aluno;

SELECT todos_ids.id_aluno, n_emprestimos
FROM (SELECT id as id_aluno FROM utilizador) as todos_ids
RIGHT JOIN (SELECT id_aluno_emp, id_aluno_res, id_aluno_ace, n_emprestimos, n_reservas, n_acessos
            FROM (SELECT id_aluno as id_aluno_emp, COUNT(id_aluno) as n_emprestimos
                                    FROM bd053_schema.emprestar_utilizador
                                    GROUP BY id_aluno)
            FULL OUTER JOIN (SELECT id_aluno_res,id_aluno_ace, n_acessos,n_reservas
                            FROM (SELECT id_aluno as id_aluno_res, COUNT(id_aluno) as n_reservas
                                    FROM reserva_utilizador
                                    GROUP BY id_aluno)
                            FULL OUTER JOIN (SELECT id_aluno as id_aluno_ace, COUNT(id_aluno) as n_acessos 
                                            FROM acesso
                                            GROUP BY id_aluno)
                            ON id_aluno_res = id_aluno_ace) AS outros_2
            ON id_aluno_emp = outros_2.id_aluno_res
            OR id_aluno_emp = outros_2.id_aluno_ace
            GROUP BY id_aluno_emp, id_aluno_ace, id_aluno = id_aluno_res,id_aluno,n_reservas,n_acessos) as outros
ON (todos_ids.id_aluno = outros.id_aluno_emp 
OR todos_ids.id_aluno = outros.id_aluno_res
OR todos_ids.id_aluno = outros.id_aluno_ace);

select todo.id_aluno, COUNT(emprestimo_id) as n_emprestimos 
    FROM ( select id as id_aluno FROM utilizador) as todo
    LEFT OUTER JOIN ( select id_aluno,emprestimo_id FROM emprestar_utilizador) as emp
    ON todo.id_aluno = emp.id_aluno
    GROUP BY todo.id_aluno;


SELECT T1.id_aluno, n_emprestimos, n_acessos
FROM (select todo.id_aluno, COUNT(emprestimo_id) as n_emprestimos 
    FROM ( select id as id_aluno FROM utilizador) as todo
    LEFT OUTER JOIN ( select id_aluno,emprestimo_id FROM emprestar_utilizador) as emp
    ON todo.id_aluno = emp.id_aluno
    GROUP BY todo.id_aluno) as T1
LEFT OUTER JOIN (select todo.id_aluno, COUNT(tempo_acesso) as n_acessos 
        FROM ( select id as id_aluno FROM utilizador) as todo
        LEFT OUTER JOIN ( select id_aluno,tempo_acesso FROM acesso) as emp
        ON todo.id_aluno = emp.id_aluno
        GROUP BY todo.id_aluno) as T2
ON T1.id_aluno = T2.id_aluno;


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



SELECT *
FROM (SELECT * FROM ids_inusados('livro'))
CROSS JOIN ids_inusados('emprestimo');


SELECT titulo
FROM livro
WHERE genero IN ( SELECT genero FROM emprestar_utilizador NATURAL JOIN livro WHERE id_aluno = 1) 
OR  genero IN ( SELECT genero FROM (SELECT * FROM reserva_livro NATURAL JOIN reserva_utilizador) as reservas INNER JOIN livro ON reservas.livro_id = livro.id WHERE id_aluno = 1)
OR genero IN ( SELECT genero FROM livro_acessado NATURAL JOIN livro WHERE id_aluno = 1)
ORDER BY avaliacao DESC;

SELECT * FROM emprestar_utilizador FULL OUTER JOIN (SELECT id_aluno AS id_aluno_2 FROM reserva_utilizador FULL OUTER JOIN livro_acessado ON reserva_utilizador.id_aluno = livro_acessado.id_aluno ) as outros ON emprestar_utilizador.id_aluno = outros.id_aluno_2;

SELECT emprestar_utilizador.id_aluno, reserva_utilizador.id_aluno FROM emprestar_utilizador FULL OUTER JOIN reserva_utilizador ON emprestar_utilizador.id_aluno = reserva_utilizador.id_aluno;

SELECT * FROM bd053_schema.emprestar_utilizador;

SELECT * FROM bd053_schema.reserva_utilizador;

SELECT * FROM autoria NATURAL JOIN livro;

DROP TABLE IF EXISTS teste CASCADE;
CREATE TABLE teste(
    id SERIAL,
    hora TIMESTAMP,
    wat INT,
    PRIMARY KEY (id),
    UNIQUE(id,hora,wat)
);

DROP TABLE IF EXISTS teste_child;
CREATE TABLE teste_child(
    id INT,
    hora TIMESTAMP,
    wat INT,
    wat_2 INT,
    PRIMARY KEY(id,wat_2),
    FOREIGN KEY (id,hora,wat) REFERENCES teste(id,hora,wat) ON DELETE CASCADE
);

INSERT INTO teste(hora,wat) VALUES ('1999-01-08 04:05',7);

INSERT INTO teste_child(id,hora,wat,wat_2) VALUES (1,'1999-01-08 04:05',7,3);

DELETE FROM teste;

SELECT * FROM teste_child ;
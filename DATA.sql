SET search_path TO bd053_schema, public;

INSERT INTO livro(titulo, genero,n_paginas ,descricao , data_publicacao, lingua ) VALUES ('Fundamentos de Cálculo Diferencial', 'Matematica', 312, 'Estudo dos princípios do cálculo diferencial com aplicações práticas e teóricas.', '2019-04-15', 'Português'), ('Teorias da Psicologia Cognitiva', 'Psicologia', 540, 'Análise das principais teorias cognitivas aplicadas à percepção e memória.', '2021-08-30', 'Português'), ('Introdução à Programação em Python', 'Tecnologia', 220, 'Guia prático para iniciantes em programação com exemplos e exercícios.', '2020-02-18', 'Português'), ('History of Ancient Civilizations', 'Historia', 450, 'A comprehensive exploration of ancient civilizations from Egypt to Rome.', '2018-11-10', 'English'), ('Principios de Economía Moderna', 'Economía', 350, 'Una introducción a las teorías económicas fundamentales y su aplicación actual.', '2020-07-24', 'Español'), ('Física Moderna: Teoria e Experimentos', 'Física', 420, 'Introdução à física moderna, com foco em relatividade e mecânica quântica.', '2017-06-05', 'Português'), ('Sociology: Theories and Applications', 'Sociologia', 360, 'Critical overview of sociological theories and their modern applications.', '2022-03-20', 'English'), ('Software Engineering: Methods and Practices', 'Ciencia da Computacao', 600, 'Comprehensive manual on software engineering and agile methodologies.', '2019-12-10', 'English'), ('Chimie Organique: Fondements et Applications', 'Quimica', 520, 'Étude des réactions organiques et de leurs applications industrielles.', '2020-09-03', 'Français'),
 ('Antropología Cultural: Una Introducción', 'Antropología', 380, 'Exploración de la cultura, identidad y diversidad social.', '2021-06-15', 'Español'), ('Metodologia da Pesquisa Científica', 'Educação', 270, 'Guia sobre métodos de pesquisa qualitativa e quantitativa.', '2018-05-21', 'Português'), ('Gestão de Projetos: Teoria e Prática', 'Administração', 410, 'Fundamentos da gestão moderna de projetos com estudo de casos.', '2020-10-09', 'Português'), ('Diritto Costituzionale Italiano', 'Direito', 580, 'Analisi della Costituzione italiana e dei suoi principi fondamentali.', '2021-01-12', 'Italiano'), ('Bioquímica Celular', 'Biologia', 495, 'Exploração dos processos bioquímicos fundamentais da célula.', '2019-09-28', 'Português'), ('Didática e Prática Docente', 'Educação', 320, 'Reflexões sobre metodologias e práticas na formação de professores.', '2022-07-11', 'Português'), ('Architecture Contemporaine', 'Arquitetura', 380, 'Étude des tendances architecturales du XXIe siècle.', '2018-03-04', 'Français'), ('Marketing Estratégico', 'Administração', 340, 'Ferramentas e estratégias para posicionamento e competitividade empresarial.', '2020-11-25', 'Português'), ('Statistical Methods for Social Sciences', 'Estatistica', 310, 'Introduction to applied statistics for social science data analysis.', '2019-06-14', 'English'), ('Anatomía Humana Básica', 'Medicina', 590, 'Descripción completa de la estructura y funcionamiento del cuerpo humano.', '2017-08-30', 'Español'), ('Linguística Geral', 'Linguistica', 400, 'Estudo das estruturas da linguagem e seus aspectos sociais e culturais.', '1916-12-08', 'Português'),
 ('Thermodynamics and Heat Transfer', 'Engenharia', 480, 'Comprehensive introduction to thermodynamics and heat transfer concepts.', '2020-01-10', 'English'), ('Matemáticas Discretas', 'Matematica', 350, 'Conceptos básicos de la lógica y teoría de conjuntos aplicados a la computación.', '2021-09-22', 'Español'), ('Introdução à Filosofia Moderna', 'Filosofia', 370, 'Análise dos principais pensadores e correntes da filosofia moderna.', '2019-05-13', 'Português'), ('Introduction à la Microéconomie', 'Economia', 310, 'Cours introductif sur les principes de la microéconomie.', '2018-07-16', 'Français'), ('Database Systems: Design and Implementation', 'Ciencia da Computacao', 530, 'Comprehensive guide to database theory and SQL implementation.', '2020-02-25', 'English'), ('Psicología del Aprendizaje', 'Psicologia', 460, 'Estudio de los procesos cognitivos relacionados con el aprendizaje humano.', '2019-11-11', 'Español'), ('Genética Molecular', 'Biologia', 500, 'Discussão dos princípios e técnicas da genética molecular moderna.', '2018-09-20', 'Português'), ('Gestione Aziendale', 'Economia', 410, 'Analisi dei principi fondamentali della gestione aziendale.', '2020-03-17', 'Italiano'), ('Modern Physics and Quantum Theory', 'Fisica', 440, 'Comprehensive discussion of quantum theory and its experimental evidence.', '2021-04-22', 'English'), ('História da Arte Contemporânea', 'Arte', 385, 'Análise das principais obras e movimentos artísticos do século XX.', '2017-06-07', 'Português'), ('Sociología Urbana', 'Sociologia', 350, 'Estudio de la dinámica social en entornos urbanos contemporáneos.', '2021-03-10', 'Español'), 
('Machine Learning: Foundations and Practice', 'Ciencia da Computacao', 480, 'A detailed introduction to algorithms and applications of machine learning.', '2020-10-05', 'English'), ('Introdução ao Direito Penal', 'Direito', 560, 'Estudo das normas e princípios do direito penal brasileiro.', '2019-02-08', 'Português'), ('Ecologia e Sustentabilidade', 'Ciencias Ambientais', 390, 'Discussão sobre ecossistemas, conservação e práticas sustentáveis.', '2022-01-12', 'Português'), ('Philosophie Morale Contemporaine', 'Filosofia', 420, 'Analyse des débats contemporains sur la morale et l’éthique.', '2018-12-19', 'Français'), ('Mathematical Logic and Proof Techniques', 'Matematica', 360, 'Introduction to formal logic and mathematical proof construction.', '2019-09-27', 'English'), ('Bioética e Saúde Pública', 'Medicina', 300, 'Reflexões sobre ética, biotecnologia e saúde coletiva.', '2021-11-23', 'Português'), ('Historia de la Educación', 'Educacao', 375, 'Análisis histórico del desarrollo de los sistemas educativos.', '2020-08-04', 'Español'), ('Introduction à la Psychologie Sociale', 'Psicologia', 390, 'Présentation des principaux concepts de la psychologie sociale.', '2019-10-13', 'Français'), ('Computer Networks: Concepts and Practice', 'Ciencia da Computacao', 510, 'Comprehensive explanation of network protocols and architectures.', '2021-02-20', 'English'),
 ('Análise de Dados com R', 'Estatistica', 340, 'Introdução à análise de dados estatísticos utilizando R.', '2020-09-29', 'Português'), ('Economía Internacional', 'Economía', 470, 'Análisis de los flujos económicos globales y el comercio internacional.', '2018-06-18', 'Español'), ('Fundamentos de Engenharia Civil', 'Engenharia', 580, 'Abordagem teórica e prática sobre estruturas e materiais de construção.', '2022-05-27', 'Português'), ('Artificial Intelligence: Concepts and Methods', 'Ciencia da Computacao', 610, 'Exploration of AI algorithms, models, and ethical considerations.', '2021-08-14', 'English'), ('Gestão de Recursos Humanos', 'Administração', 355, 'Estudo sobre gestão de pessoas e cultura organizacional.', '2019-07-02', 'Português'), ('Psicopatología Clínica', 'Psicologia', 520, 'Estudio de los trastornos mentales y su tratamiento clínico.', '2020-04-21', 'Español'), ('Théorie des Jeux et Applications', 'Economia', 400, 'Étude des modèles de théorie des jeux et de leurs applications.', '2018-10-09', 'Français'), ('Neuroscienze Cognitive', 'Psicologia', 460, 'Analisi dei processi cognitivi e delle funzioni cerebrali.', '2020-07-23', 'Italiano'), ('Historia Medieval Europea', 'Historia', 480, 'Análisis detallado del desarrollo político y cultural de la Europa medieval.', '2019-03-14', 'Español'), ('Teoria Literária e Análise de Texto', 'Literatura', 340, 'Introdução à teoria da literatura e à interpretação de textos literários.', '2020-06-08', 'Português'), ('Cybersecurity Fundamentals', 'Tecnologia', 530, 'Comprehensive overview of cybersecurity concepts and best practices.', '2021-01-29', 'English'),
  ('Psicanálise e Comportamento', 'Psicologia', 375, 'Discussão sobre os fundamentos da psicanálise e da psicologia comportamental.', '2018-11-15', 'Português'), ('Ecología Marina', 'Biologia', 480, 'Exploración de los ecosistemas marinos y su biodiversidad.', '2022-02-05', 'Español'), ('Linguistica Comparata', 'Linguistica', 360, 'Studio comparativo delle lingue indoeuropee.', '2019-09-05', 'Italiano'), ('Philosophy of Science', 'Filosofia', 410, 'Introduction to epistemological and methodological questions in science.', '2020-05-11', 'English'), ('Química Inorgânica Aplicada', 'Quimica', 450, 'Análise dos compostos inorgânicos e suas aplicações tecnológicas.', '2021-10-27', 'Português'), ('Literatura Brasileira Contemporânea', 'Literatura', 370, 'Estudo das principais obras e autores da literatura brasileira recente.', '2019-06-12', 'Português'), ('Historia del Arte Barroco', 'Arte', 430, 'Estudio del arte barroco en Europa y América Latina.', '2018-04-23', 'Español'), ('Gestione Finanziaria', 'Economia', 420, 'Approccio pratico alla gestione e analisi finanziaria d’impresa.', '2020-12-14', 'Italiano'), ('Advanced Algorithms and Data Structures', 'Ciencia da Computacao', 590, 'Comprehensive course on algorithmic techniques and efficiency analysis.', '2021-03-17', 'English'), ('Introdução à Probabilidade', 'Matematica', 310, 'Fundamentos teóricos e práticos da probabilidade e estatística.', '2020-07-19', 'Português'), ('Psychologie du Développement', 'Psicologia', 460, 'Étude des processus cognitifs et affectifs tout au long de la vie.', '2019-09-26', 'Français'),
   ('Teologia Contemporânea', 'Teologia', 340, 'Reflexões teológicas sobre fé e sociedade moderna.', '2021-05-18', 'Português'), ('Dicionário Técnico para Engenharia', 'Idiomas', 280, 'Dicionário voltado ao vocabulário técnico utilizado em engenharia.', '2018-08-22', 'Português'), ('Computer Graphics and Visualization', 'Ciencia da Computacao', 520, 'Techniques for rendering, modeling, and visualization in computer graphics.', '2020-10-30', 'English'), ('Gestão Ambiental e Desenvolvimento Sustentável', 'Engenharia Ambiental', 430, 'Abordagem integrada sobre recursos naturais e sustentabilidade.', '2021-09-02', 'Português'), ('Historia de América Latina Contemporánea', 'Historia', 480, 'Análisis político y social de América Latina en los siglos XIX y XX.', '2019-02-14', 'Español'), ('Chimie Analytique', 'Quimica', 390, 'Étude des méthodes analytiques utilisées en laboratoire.', '2020-06-23', 'Français'), ('Antropologia Filosófica', 'Filosofia', 350, 'Estudo das dimensões ontológicas e existenciais do ser humano.', '2018-11-06', 'Português'), ('Applied Econometrics', 'Economia', 510, 'Techniques and models used for empirical economic analysis.', '2022-04-04', 'English'), ('Psicologia Escolar', 'Psicologia', 330, 'Abordagem sobre o papel do psicólogo no ambiente educacional.', '2021-07-12', 'Português'), ('Arquitetura Sustentável', 'Arquitetura', 400, 'Discussão sobre práticas ecológicas e eficiência energética em construções.', '2019-10-16', 'Português'), ('Historia Moderna Europea', 'Historia', 470, 'Estudio del Renacimiento, la Reforma y la expansión europea.', '2020-09-11', 'Español'),
  ('Mathematical Modeling for Engineers', 'Engenharia', 550, 'Application of mathematical models in solving engineering problems.', '2021-11-20', 'English'), ('Gestão Pública e Políticas Governamentais', 'Administracao Publica', 420, 'Análise da formulação e implementação de políticas públicas.', '2022-03-09', 'Português'), ('Linguistique Appliquée', 'Linguistica', 360, 'Introduction aux théories et méthodes de la linguistique appliquée.', '2020-08-28', 'Français'), ('Econometría Avanzada', 'Economía', 510, 'Modelos econométricos para análisis financiero y predicciones.', '2019-12-07', 'Español'), ('Direito Internacional Público', 'Direito', 590, 'Estudo das normas que regem as relações entre Estados e organizações internacionais.', '2021-02-26', 'Português'), ('Neural Networks and Deep Learning', 'Ciencia da Computacao', 610, 'Advanced concepts in neural networks and deep learning frameworks.', '2020-06-30', 'English'), ('Introdução à Geopolítica', 'Ciencia Politica', 350, 'Análise das dinâmicas de poder e influência entre Estados modernos.', '2018-05-25', 'Português'), ('Arte e Estética', 'Filosofia', 370, 'Reflexões sobre estética, beleza e expressão artística.', '2020-12-17', 'Português'), ('Historia del Pensamiento Económico', 'Economía', 400, 'Evolución histórica de las ideas y teorías económicas.', '2021-09-06', 'Español'), ('Statistique Avancée', 'Matematica', 470, 'Cours complet sur les méthodes statistiques avancées.', '2019-04-03', 'Français'), ('Teoria dos Jogos e Estratégia', 'Economia', 390, 'Análise dos conceitos de teoria dos jogos e suas aplicações empresariais.', '2021-06-09', 'Português'),
  ('Journal of African earth sciences vol.14','Geologia' ,270,'14º Volume da publicacao Journal of African earth sciences','2021-11-20', 'English'),
  ('Journal of African earth sciences.vol.11','Geologia' ,340,'14º Volume da publicacao Journal of African earth sciences','2023-09-15', 'English'),
('Brazilian journal of probability and statistics nº7','Estatistica' ,204,'7º Publicação da publicacao Brazilian journal of probability and statistics','2021-03-17', 'English'),
('Brazilian journal of probability and statistics nº5','Estatistica' ,187,'5º Publicação da publicacao Brazilian journal of probability and statistics','2020-10-15', 'English'),
('Brazilian journal of probability and statistics nº10', 'Estatistica' ,195,'10º Publicação da publicacao Brazilian journal of probability and statistics','2022-09-21', 'English'),
('Renovação : revista do ensino em nova acção vol.1','Educacao' ,150,'1º Volume da publicacao Journal of African earth sciences','1998-04-25', 'Portugues')
  ;

INSERT INTO fisico(id_livro,Copias_totais) VALUES 
(2,5),(3,1),(4,6),(5,7),(6,5),(8,4),(9,6),(10,1),
(11,2),(12,2),(15,3),(16,6),(17,2),(18,4),(20,6),(21,6),
(23,4),(24,7),(25,5),(26,5),(28,2),(29,2),(30,7),(32,2),
(33,3),(34,6),(40,4),(41,7),(42,4),(48,1),(49,1),(50,3),
(51,6),(53,1),(54,6),(57,1),(59,7),(60,5),(62,3),(63,7),
(67,5),(68,3),(69,2),(71,6),(74,6),(75,5),(76,3),(77,1),
(78,4),(80,7),(83,6) ;

INSERT INTO digital(id) VALUES 
(1),
 (7),
 (13),
 (14),
 (19),
 (22),
 (27),
 (30),
 (25),
 (31),
 (35),
 (36),
 (37),
 (38),
 (39),
 (43),
 (44),
 (45),
 (46),
 (47),
 (52),
 (55),
 (56),
 (58),
 (61),
 (64),
 (65),
 (66),
 (70),
 (72),
 (73),
 (79),
 (81),
 (82),
 (84)
 ;

---------------------

INSERT INTO utilizador(email,nome,categoria,faculdade,password) VALUES 
('fc1@alunos.ciencias.pt','Vitor Lima','aluno','FCUL','aaaaaa_2021#'),
('fc2@alunos.ciencias.pt','João Lima','aluno','FCUL','password'),
('fc3@alunos.ciencias.pt','Gabriel Gomes','aluno','FCUL','1234'),
('fc4@alunos.ciencias.pt','Gustavo Costa','aluno','FCUL','1234'),
('fc5@alunos.ciencias.pt','Leonardo Almeida','aluno','FCUL','1234'),
('fc6@alunos.ciencias.pt','Diego Costa','aluno','FCUL','Xy7Kp2zQdWl5'),
('fc7@alunos.ciencias.pt','Paulo Pereira','aluno','FCUL','1234'),
('fc8@alunos.ciencias.pt','Adriana Costa','aluno','FCUL','1234'),
('fc9@alunos.ciencias.pt','Carolina Souza','aluno','FCUL','1234'),
('fc10@alunos.ciencias.pt','Camila Costa','aluno','FCUL','1234'),
('fc11@alunos.ciencias.pt','Cláudia Rocha','aluno','FCUL','1234'),
('fc12@alunos.ciencias.pt','Wallace Lima','aluno','FCUL','#$##'),
('fm1@alunos.medicina.pt','Roberto Almeida','aluno','FMUL','1234'),
('fm2@alunos.medicina.pt','Wallace Lima','aluno','FMUL','Mariana!2023'),
('fm3@alunos.medicina.pt','Vânia Rocha','aluno','FMUL','1234'),
('fm4@alunos.medicina.pt','Fábio Gomes','aluno','FMUL','1234'),
('fm5@alunos.medicina.pt','Pedro Sousa','aluno','FMUL','Travesseiro#'),
('fm6@alunos.medicina.pt','Júlia Barbosa','aluno','FMUL','Mar_2023#'),
('fm7@alunos.medicina.pt','Vanessa Ferreira','aluno','FMUL','1234'),
('fm8@alunos.medicina.pt','Gabriel Lima','aluno','FMUL','1234');

INSERT INTO aluno(id,curso,id_aluno) VALUES
(1,'Matemática Aplicada',60391),
(3,'Bioquímica',60391),
(4,'Química',60391),
(5,'Estatistica Aplicada',60391),
(15,'Medicina',60391);

 -- até 12 ciencias, até 20 medicina

----------------------

INSERT INTO periodico(nome,periodicidade) VALUES
('Journal of African earth sciences', 'irregular'),
('Brazilian journal of probability and statistics', 'semestral'),
('Renovação : revista do ensino em nova acção','irregular');

INSERT INTO periodicidade(livro_id,periodico_id) VALUES
(85,1),
(86,1),
(87,2),
(88,2),
(89,2),
(90,3);

INSERT INTO autor(nome) VALUES 
('Carlos Almeida'),('Fernanda Souza'),('Roberto Martins'),('Johnathan Harris'),
('María González'),('Eduardo Lima'),('Emily Roberts'),('Michael Stewart'),
('Sophie Dupont'),('Juan Pérez'),('Ana Costa'),('Ricardo Silva'),('Giovanni Romano'),
('Patrícia Oliveira'),('Fernanda Almeida'),('Marc Lefevre'),('Lucas Andrade'),
('Sarah Thompson'),('Carlos Hernández'),('Leopoldo Gomes'),('Henry Williams'),
('Antonio Ruiz'),('Juliana Silva'),('Jean-Pierre Martin'),('David Clark'),
('Laura González'),('Eduardo Costa'),('Alessandro Bianchi'),('William Thompson'),
('João Marques'),('Marta Gómez'),('James Walker'),('Cláudio Martins'),('Roberta Lima'),
('Élisabeth Durand'),('John Lewis'),('Pedro Almeida'),('Carlos Romero'),('Lucie Lefevre'),
('Robert Fisher'),('Mário Souza'),('Ricardo Sánchez'),('Fernanda Rocha'),
('Michael Anderson'),('Isabela Martins'),('Antonio Pérez'),
('François Rousseau'),('Giulia Esposito'),('José Fernández'),('Paulo Oliveira'),
('Samuel Green'),('Mariana Santos'),('Laura Martínez'),('Marco Bianchi'),
('Richard Evans'),('Isabel Costa'),('José Silva'),('Carlos Díaz'),('Antonio Rossi'),
('Jessica Williams'),('Rogério Oliveira'),('Jean-Claude Martin'),('Marcos Oliveira'),
('Henrique Costa'),('Robert Blake'),('Luciana Alves'),('Mario Sánchez'),('Pierre Lefevre')
,('Ricardo Santos'),('Paul Johnson'),('Cláudia Ferreira'),('André Costa'),
('Luis Martínez'),('Benjamin Scott'),('Tiago Rocha'),('Claude Bernard'),
('Gabriel Rodríguez'),('Isabel Almeida'),('George Davis'),('Carlos Pereira'),
('Sofia Martins'),('Juan Silva'),('Bernard Lefevre'),('Aline Souza'),('Alice Mendes'),
;

INSERT INTO autoria 
(SELECT livro.id as livro_id, autor.id as autor_id 
FROM autor FULL OUTER JOIN livro
ON autor.id = livro.id
WHERE autor.id IS NOT NULL);

INSERT INTO autoria(livro_id,autor_id) VALUES (1,22),(61,22);

--------------------------

INSERT INTO biblioteca(nome,faculdade) VALUES 
('Biblioteca FLUL', 'Faculdade de letras'),
('Biblioteca Central FCUL', 'Faculdade de ciencias'),
('Biblioteca C6 FCUL', 'Faculdade de ciencias'),
('Biblioteca FMUL', 'Faculdade de medicina'),
('Biblioteca FPUL', 'Faculdade de psicologia');

INSERT INTO sala(capacidade) VALUES 
(4),(2),
(3),(5),
(4),
(3),(5),(5),(3),(3),(3),(4),(4),(4);

INSERT INTO local_sala(biblioteca_id,sala_id) VALUES
(5,1),(4,2),(3,3),(2,4),(2,5),(2,6),(1,7),(1,8),(1,9),(1,10),(1,11)
,(5,12),(4,13),(3,14);

INSERT INTO funcionario(password) VALUES
('1234'),
('1234'),
('&(&B)UU(B)');

INSERT INTO local_trabalho(funcionario_id,biblioteca_id) VALUES
(1,2),
(2,3),
(3,1);


INSERT INTO local_livro(livro_id,biblioteca_id,n_disp,total_copias) VALUES
(2,2,2,2),
(3,1,1,1),
(4,3,2,2),
(5,1,4,4),
(6,1,4,4),
(8,4,4,4);

--------------------------
-- 
SELECT * FROM emprestimo;
CALL adicionar_emprestimo(1,'2019-04-15' , DATE '2019-04-15' + 13, 1, 2, TRUE, 1);
CALL adicionar_emprestimo(2,'2025-04-15', DATE '2025-04-15' + 12, 1, 2, FALSE, 2);
CALL adicionar_emprestimo(1,'2025-04-15', DATE '2025-04-15' + 10, 1, 2, FALSE, 3);


CALL adicionar_reserva(1,'2019-04-15', DATE '2019-04-15' + 2, 1, 2, FALSE, 1);
CALL adicionar_reserva(3,CURRENT_DATE, CURRENT_DATE + 5, 1, 2, TRUE, 2);
CALL adicionar_reserva(2,CURRENT_DATE - 3, CURRENT_DATE + 1, 1, 2, TRUE, 3);



INSERT INTO acesso(tempo_acesso,id_aluno) VALUES
('2024-10-19 10:23:54',3),
('2024-10-19 17:34:54',15),
('2024-12-19 23:23:54',6);

INSERT INTO livro_acessado(tempo_acesso,id_aluno,id_livro) VALUES 
('2024-10-19 10:23:54',3,44),
('2024-10-19 10:23:54',15,44),
('2024-12-19 23:23:54',6,39);

CALL atualizar_multas(CURRENT_DATE);

INSERT INTO avaliar(id_aluno,livro_id,avaliacao) VALUES
(10,39,3.1);

INSERT INTO agendar(id_aluno,sala_id,data_reserva,hora_inicio,hora_fim) VALUES 
(5,7,'2024-12-19',10,12);

INSERT INTO agenda(sala_id,data_reserva,hora_inicio,hora_fim) VALUES
(7,'2024-12-19',10,12);

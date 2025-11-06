SET search_path TO bd053_schema, public;

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
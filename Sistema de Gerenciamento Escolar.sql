CREATE DATABASE Escolar;
 
USE Escolar;
 
DROP DATABASE Escolar;
 
-- CRIAÇÃO DAS TABELAS
CREATE TABLE TBL_turmas (
id_turma INT IDENTITY NOT NULL,
nome VARCHAR(50) NOT NULL,
disciplina VARCHAR(50) NOT NULL,
PRIMARY KEY(id_turma)
);
 
CREATE TABLE TBL_alunos (
id_aluno INT IDENTITY NOT NULL,
nome VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
PRIMARY KEY(id_aluno)
);
 
CREATE TABLE TBL_inscricoes (
id_inscricao INT IDENTITY NOT NULL,
id_aluno INT NOT NULL,
id_turma INT NOT NULL,
data_inscricao DATETIME NOT NULL DEFAULT (GETDATE()),
PRIMARY KEY(id_inscricao),
FOREIGN KEY (id_aluno) REFERENCES TBL_alunos (id_aluno),
FOREIGN KEY(id_turma) REFERENCES TBL_turmas(id_turma)
);

-- INSERTS
INSERT INTO TBL_turmas (nome, disciplina)
	VALUES 
			('Turma 1','Disciplina 1'),
			('Turma 2','Disciplina 2'),
			('Turma 3','Disciplina 3'),
			('Turma 4','Disciplina 4'),
			('Turma 5','Disciplina 5'),
			('Turma 6','Disciplina 6'),
			('Turma 7','Disciplina 7'),
			('Turma 8','Disciplina 8'),
			('Turma 9','Disciplina 9'),
			('Turma 10','Disciplina 10');
INSERT INTO TBL_alunos (nome, email)
	VALUES 
			('Fowler', 'fleale0@wordpress.com'),
			('Titus', 'tmanueau1@123-reg.co.uk'),
			('Bartolomeo', 'bwillshire2@canalblog.com'),
			('Gerrie', 'gbauld3@discovery.com'),
			('Barbie', 'bpringuer4@shutterfly.com'),
			('Tara', 'tnorthcott0@dropbox.com'),
			('Angel', 'aeagers1@mediafire.com'),
			('Lars', 'larbuckel2@arizona.edu'),
			('Ilaire', 'igilvear3@hibu.com'), 
			('Jacques', 'jstreet4@flavors.me');

INSERT INTO TBL_inscricoes (id_aluno, id_turma)
	VALUES
			(1, 1),
			(2, 2),
			(3, 3),
			(4, 4),
			(5, 5);

-- SELECTS
SELECT * FROM TBL_alunos
SELECT * FROM TBL_turmas
SELECT * FROM TBL_inscricoes

-- Listar todos os alunos e as turmas em que estão inscritos
SELECT TBL_alunos.nome AS Nome_do_Aluno, TBL_turmas.nome AS Nome_da_Turma
FROM TBL_alunos INNER JOIN TBL_turmas ON TBL_alunos.id_aluno = TBL_turmas.id_turma
INNER JOIN TBL_inscricoes ON TBL_turmas.id_turma = TBL_inscricoes.id_inscricao;

-- Encontrar alunos que não estão inscritos em nenhuma turma
SELECT TBL_alunos.nome AS Nome_do_Aluno, TBL_inscricoes.id_inscricao AS Inscrição
FROM TBL_alunos LEFT JOIN TBL_inscricoes ON TBL_alunos.id_aluno = TBL_inscricoes.id_inscricao
WHERE TBL_inscricoes.id_inscricao IS NULL;

-- Listar turmas que não têm alunos inscritos
SELECT TBL_turmas.nome AS Nome_da_Turma, TBL_inscricoes.id_inscricao AS Inscrição
FROM TBL_turmas LEFT JOIN TBL_inscricoes ON TBL_turmas.id_turma = TBL_inscricoes.id_turma
WHERE TBL_inscricoes.id_inscricao IS NULL;

-- Contar o número de alunos inscritos em cada turma
SELECT TBL_turmas.nome AS Nome_da_Turma, COUNT(TBL_inscricoes.id_aluno) AS Números_de_Alunos_Inscritos
FROM TBL_turmas INNER JOIN TBL_inscricoes ON TBL_turmas.id_turma = TBL_inscricoes.id_turma
GROUP BY TBL_turmas.nome;

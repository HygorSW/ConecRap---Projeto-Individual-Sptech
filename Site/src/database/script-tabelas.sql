	CREATE DATABASE Conecrap;
	USE Conecrap;

	-- Usuário
	CREATE TABLE usuario (
		idUsuario INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(50),
		email VARCHAR(50) UNIQUE,
		senha VARCHAR(50),
		criado_em DATE
	);

	-- Posts
	CREATE TABLE posts (
		idPost INT PRIMARY KEY AUTO_INCREMENT,
		titulo VARCHAR(100),
		descricao VARCHAR(150),
		url VARCHAR(150),
		categoria VARCHAR(45),
		criado_em DATETIME,
		fk_usuario INT,
		FOREIGN KEY (fk_usuario) REFERENCES usuario(idUsuario)
	);

	-- Quiz
	CREATE TABLE Quiz (
		idQuiz INT PRIMARY KEY AUTO_INCREMENT,
		nomeQuiz VARCHAR(45)
	);

	-- Questoes
	CREATE TABLE Questoes (
		idQuestoes INT AUTO_INCREMENT PRIMARY KEY,
        fkQuiz INT,
		pergunta_texto TEXT NOT NULL,
		alternativaA VARCHAR(255) NOT NULL,
		alternativaB VARCHAR(255) NOT NULL,
		alternativaC VARCHAR(255) NOT NULL,
		alternativaD VARCHAR(255) NOT NULL,
		alternativa_correta CHAR(1) NOT NULL,
        FOREIGN KEY (fkQuiz) REFERENCES Quiz(idQuiz)

	);

	-- Tentativas (com correção de nome da constraint e uso adequado de FK)
	CREATE TABLE Tentativas (
		idTentativa INT AUTO_INCREMENT,
		fkUsuario INT,
		fkQuiz INT,
		dataHora  DATETIME,
		PRIMARY KEY(idTentativa),
		FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
		FOREIGN KEY (fkQuiz) REFERENCES Quiz(idQuiz)
	);


	CREATE TABLE Resultado (
		idResultado INT AUTO_INCREMENT PRIMARY KEY,
		fkTentativa INT,
		totalAcertos INT,
		totalErros INT,
		dataHoraFim DATETIME,
		FOREIGN KEY (fkTentativa) REFERENCES Tentativas(idTentativa)
	);


-- insert quiz
INSERT INTO Quiz (nomeQuiz) VALUES ('História do Hip-Hop');

	INSERT INTO usuario (nome, email, senha, criado_em) VALUES
	('Akira', 'akirinhaMatadorDeDragão@gmail.com', '123456', CURDATE());


INSERT INTO posts (titulo, categoria, descricao, url, fk_usuario, criado_em) VALUES
('Racionais MC’s: Voz das Favelas', 'Informativos e Conscientização', 'Entrevista com os Racionais MC\'s abordando sua trajetória e impacto na cultura Hip-Hop brasileira.', 'mEIvL6VZ4bM', 1, CURDATE()),
('DJ Kool Herc e o Nascimento do Hip-Hop', 'Informativos e Conscientização', 'Documentário sobre DJ Kool Herc e sua contribuição para o surgimento do Hip-Hop.', 'Jdb3MTz7xXg', 1, CURDATE()),
('Breakdance: Dante e Identidade nas Ruas', 'Dança e Movimento', 'Documentário que explora a história e a cultura do breakdance.', '1UMgadbZkmk', 1, CURDATE()),
('Grafite: Arte e Resistência Urbana', 'Arte e Grafite', 'Documentário sobre o grafite como forma de expressão e resistência nas cidades.', 'CT-S7ioy3pg', 1, CURDATE());

	-- quiz
	-- Inserindo questões
INSERT INTO Questoes (fkQuiz, pergunta_texto, alternativaA, alternativaB, alternativaC, alternativaD, alternativa_correta) VALUES
(1, 'Em que ano DJ Kool Herc realizou a festa considerada o nascimento do Hip-Hop?', '1970', '1973', '1979', '1982', 'B'),
(1, 'Onde surgiu o movimento Hip-Hop?', 'Nova Iorque', 'Los Angeles', 'Detroit', 'Atlanta', 'A'),
(1, 'Qual destes não é um dos quatro elementos clássicos do Hip-Hop?', 'Grafite', 'Breaking', 'Freestyle', 'Trap', 'D'),
(1, 'Qual função não está entre os quatro elementos principais do Hip-Hop?', 'MC', 'DJ', 'Produtor', 'B-Boy', 'C'),
(1, 'Teste', 'Errada', 'Errada', 'correta', 'Errada', 'C'),
(1, 'Qual rapper fez parte do grupo N.W.A?', 'Notorious B.I.G.', 'Tupac', 'Eazy-E', 'Jay-Z', 'C');


-- tentativa
INSERT INTO Tentativas (fkUsuario, fkQuiz, dataHora)
VALUES (1, 1, NOW());

	-- posts
	SELECT 
	  a.idPost,
	  a.titulo,
	  a.descricao,
	  a.url,
	  a.criado_em,
	  a.fk_usuario,
	  u.idUsuario,
	  u.nome,
	  u.email,
	  u.senha
	FROM posts a
	INNER JOIN usuario u
	  ON a.fk_usuario = u.idUsuario
	ORDER BY RAND();

	-- post por categoria
	SELECT 
	  categoria,
	  COUNT(*) AS total_posts   
	FROM posts
	GROUP BY categoria
	ORDER BY total_posts DESC;
    
    -- categoria mais post dash
   SELECT 
  p.categoria,
  COUNT(*) AS total_posts
FROM usuario as u join posts as p
on p.fk_usuario = u.idUsuario 
where u.idUsuario = 1
GROUP BY categoria
ORDER BY total_posts DESC 
LIMIT 1;


	-- ranking
SELECT 
  u.nome AS usuario,
  COUNT(r.idResultado) AS tentativas,
  SUM(r.totalAcertos) AS total_acertos,
  SUM(r.totalErros) AS total_erros,
  ROUND(SUM(r.totalAcertos) / (SUM(r.totalAcertos + r.totalErros)) * 100, 2) AS porcentagem_acertos
FROM Resultado r
JOIN Tentativas t ON r.fkTentativa = t.idTentativa
JOIN usuario u ON t.fkUsuario = u.idUsuario
GROUP BY u.idUsuario
ORDER BY porcentagem_acertos DESC;

-- selects from
select * from posts;
select * from usuario;
select * from Quiz;
select * from tentativas order	 by dataHora desc;
select * from questoes;
select * from resultado order by dataHoraFim desc;


-- puxa todos os dados referente a tentativa do user
SELECT 
    r.idResultado,
    u.nome AS nome,
    r.totalAcertos AS acertos,
    r.totalErros AS erros,
    t.dataHora AS inicio,
    (SELECT COUNT(*) FROM questoes WHERE fkQuiz = q.idQuiz) AS qtd_questoes,
    r.dataHoraFim AS fim,
    DATE(r.dataHoraFim) AS data_fim,
TIMEDIFF(r.dataHoraFim, t.dataHora) AS tempo
FROM Tentativas AS t
JOIN usuario AS u ON t.fkUsuario = u.idUsuario
JOIN resultado AS r ON r.fkTentativa = t.idTentativa
JOIN quiz AS q ON t.fkQuiz = q.idQuiz
where u.idUsuario = 1;




	-- PEGA A ULTIMA TENTATIVA
    SELECT idTentativa
FROM Tentativas
WHERE fkUsuario = 1
ORDER BY dataHora DESC
LIMIT 1;


-- select qtd categorias
SELECT 
    u.nome AS usuario,
    p.categoria,
    COUNT(p.idPost) AS total_posts
FROM posts p
JOIN usuario u ON p.fk_usuario = u.idUsuario
WHERE u.idUsuario = 1
GROUP BY u.idUsuario, p.categoria;



-- qtd de post na ultima semana, categorizado pelos dias da semana seg, terça
	
SELECT 
    DAYNAME(criado_em) AS dia_semana,
    COUNT(*) AS quantidade_posts,
    criado_em
FROM posts
 WHERE 
    fk_usuario = 1 and criado_em >= NOW() - INTERVAL 7 DAY
GROUP BY dia_semana;






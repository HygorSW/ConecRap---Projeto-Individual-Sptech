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
(1, 'Qual é considerada a data de nascimento oficial do hip hop?', '11 de agosto de 1973', '4 de julho de 1980', '2 de setembro de 1975', '10 de outubro de 1970', 'A'),
(1, 'Quem é o artista conhecido como "o pai do hip hop"?', 'DJ Premier', 'Grandmaster Flash', 'DJ Kool Herc', 'Afrika Bambaataa', 'C'),
(1, 'Qual foi o primeiro grande sucesso de rap a alcançar o mainstream?', 'Fight the Power – Public Enemy', 'Rapper’s Delight – Sugarhill Gang', 'The Message – Grandmaster Flash', 'Straight Outta Compton – N.W.A', 'B'),
(1, 'Qual grupo é conhecido por popularizar o gangsta rap?', 'Beastie Boys', 'N.W.A', 'Run-D.M.C.', 'Wu-Tang Clan', 'B'),
(1, 'Qual rapper ficou famoso com o álbum "Illmatic"?', 'Tupac Shakur', 'Nas', 'Jay-Z', 'Snoop Dogg', 'B'),
(1, 'Qual elemento NÃO faz parte dos 4 pilares originais do hip hop?', 'Graffiti', 'Breakdance', 'Beatbox', 'DJing', 'C'),
(1, 'Em que cidade nasceu o movimento hip hop?', 'Los Angeles', 'Nova York', 'Atlanta', 'Chicago', 'B'),
(1, 'Qual rapper é conhecido por seu alter ego "Slim Shady"?', 'Eminem', 'Drake', '50 Cent', 'Kendrick Lamar', 'A'),
(1, 'Qual dessas é uma gravadora famosa do hip hop dos anos 1990?', 'Death Row Records', 'Sub Pop', 'Big Machine', 'Roadrunner', 'A'),
(1, 'Qual artista de hip hop brasileiro lançou o álbum "Sobrevivendo no Inferno"?', 'Sabotage', 'Racionais MC’s', 'Criolo', 'Emicida', 'B');

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
    COUNT(*) AS quantidade_posts
FROM posts
 WHERE 
    fk_usuario = 1 and criado_em >= NOW() - INTERVAL 7 DAY
GROUP BY dia_semana;


select
	day(p.criado_em) as dia,
    DAYNAME(p.criado_em) AS dia_semana,
    COUNT(p.criado_em) as total_post
    from posts as p where p.fk_usuario = 1
     and p.criado_em >= now() - INTERVAL 7 day
     group by dia_semana, dia ;
		
     
     





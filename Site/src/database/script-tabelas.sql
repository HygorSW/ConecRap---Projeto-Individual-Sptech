CREATE DATABASE Conecrap;
USE Conecrap;

CREATE TABLE usuario (
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	email VARCHAR(50) UNIQUE,
	senha VARCHAR(50),
    criado_em DATE
);

CREATE TABLE posts (
	idPost INT PRIMARY KEY AUTO_INCREMENT,
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	url VARCHAR(150),
    categoria VARCHAR(45),
	criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
	fk_usuario INT,
	FOREIGN KEY (fk_usuario) REFERENCES usuario(idUsuario)
);

-- Tabela: Questoes
CREATE TABLE Questoes (
    idQuestoes INT AUTO_INCREMENT PRIMARY KEY,
	pergunta_texto TEXT NOT NULL,
    alternativaA VARCHAR(255) NOT NULL,
    alternativaB VARCHAR(255) NOT NULL,
    alternativaC VARCHAR(255) NOT NULL,
    alternativaD VARCHAR(255) NOT NULL,
    alternativa_correta CHAR(1) NOT NULL
);

-- Tabela: Resultado
CREATE TABLE Resultado (
    idResultado INT AUTO_INCREMENT PRIMARY KEY,
    fkQuestoes INT NOT NULL,
    fkUsuario INT NOT NULL,
    resposta_usuario CHAR(1) NOT NULL,
    resultado_quiz INT NOT NULL,
    tentativa INT NOT NULL DEFAULT 1,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (fkQuestoes) REFERENCES Questoes(idQuestoes),
    FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);


INSERT INTO usuario (nome, email, senha, criado_em) VALUES
('Akira', 'akirinhaMatadorDeDragão@gmail.com', '123456', CURDATE()),
('Luna', 'luna.bgirl@email.com', 'hiphop2025', CURDATE()),
('DJ Max', 'djmax@turntable.com', 'beatdrop', CURDATE());


INSERT INTO posts (titulo, descricao, url, categoria, fk_usuario) VALUES
('Racionais MC’s: Voz das Favelas', 'Entrevista com os Racionais MC\'s abordando sua trajetória e impacto na cultura Hip-Hop brasileira.', 'mEIvL6VZ4bM', 'Entrevista', 1),
('DJ Kool Herc e o Nascimento do Hip-Hop', 'Documentário sobre DJ Kool Herc e sua contribuição para o surgimento do Hip-Hop.', 'Jdb3MTz7xXg', 'Documentário', 1),
('Breakdance: Dança e Identidade nas Ruas', 'Documentário que explora a história e a cultura do breakdance.', '1UMgadbZkmk', 'Dança', 1),
('Grafite: Arte e Resistência Urbana', 'Documentário sobre o grafite como forma de expressão e resistência nas cidades.', 'CT-S7ioy3pg', 'Arte Urbana', 1);

-- quiz
-- Inserindo questões
INSERT INTO Questoes (alternativaA, alternativaB, alternativaC, alternativaD, alternativa_correta, pergunta_texto) VALUES
('1970', '1973', '1979', '1982', 'B', 'Em que ano DJ Kool Herc realizou a festa considerada o nascimento do Hip-Hop?'),
('Nova Iorque', 'Los Angeles', 'Detroit', 'Atlanta', 'A', 'Onde surgiu o movimento Hip-Hop?'),
('Grafite', 'Breaking', 'Freestyle', 'Trap', 'D', 'Qual destes não é um dos quatro elementos clássicos do Hip-Hop?'),
('MC', 'DJ', 'Produtor', 'B-Boy', 'C', 'Qual função não está entre os quatro elementos principais do Hip-Hop?'),
('Notorious B.I.G.', 'Tupac', 'Eazy-E', 'Jay-Z', 'C', 'Qual rapper fez parte do grupo N.W.A?');

-- Inserindo resultados
INSERT INTO resultado (fkQuestoes, fkUsuario, resposta_usuario, resultado_quiz, tentativa) VALUES
(1, 1, 'B', 1, 1),
(2, 1, 'A', 1, 1),
(3, 1, 'A', 0, 1),
(4, 2, 'C', 1, 1),
(5, 2, 'C', 1, 1),
(1, 3, 'A', 0, 1),
(2, 3, 'C', 0, 1),
(3, 3, 'D', 1, 1);



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

-- questoes e suas respostas
SELECT 
  idQuestoes,
  pergunta_texto,
  alternativaA,
  alternativaB,
  alternativaC,
  alternativaD,
  alternativa_correta
FROM questoes;


-- quantidade de acertos e porcentagem
SELECT 
  u.nome,
  COUNT(*) AS total_questoes,
  SUM(r.resultado_quiz) AS acertos,
  (SUM(r.resultado_quiz) / COUNT(*)) * 100 AS porcentagem_acertos
FROM resultado r
JOIN usuario u ON r.fkUsuario = u.idUsuario
GROUP BY u.nome
ORDER BY acertos DESC;

-- post por categoria
SELECT 
  categoria,
  COUNT(*) AS total_posts
FROM posts
GROUP BY categoria
ORDER BY total_posts DESC;

-- ranking











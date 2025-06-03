var database = require("../database/config");

function listar() {
    console.log("ACESSEI O posts  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
            a.categoria,
            a.descricao,
            a.url,
            a.fk_usuario,
            u.idUsuario AS idUsuario,
            u.nome,
            u.email,
            u.senha
        FROM posts a
            INNER JOIN usuario u
                ON a.fk_usuario = u.idUsuario 
                    order by rand();
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function contarCategoria(idUsuario) {
    console.log("Acessei categorias!")
    var instrucaoSql = `
   SELECT 
  p.categoria,
  COUNT(*) AS total_posts
FROM usuario as u join posts as p
on p.fk_usuario = u.idUsuario 
where u.idUsuario = ${idUsuario}
GROUP BY categoria
ORDER BY total_posts DESC 
LIMIT 1;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pesquisarDescricao(texto) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function pesquisarDescricao()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
            a.descricao,
            a.url,
            a.categoria,
            a.criado_em,
            a.fk_usuario,
            u.idUsuario AS idUsuario,
            u.nome,
            u.email,
            u.senha
        FROM posts a
            INNER JOIN usuario u
                ON a.fk_usuario = u.idUsuario
        WHERE a.descricao LIKE '${texto}' order by a.criado_em desc;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarPorUsuario(idUsuario) {
    console.log("function listarPorUsuario()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
            a.descricao,
            a.categoria,
            a.url,
            a.criado_em,
            a.fk_usuario,
            u.idUsuario AS idUsuario,
            u.nome,
            u.email,
            u.senha
        FROM posts a
            INNER JOIN usuario u
                ON a.fk_usuario = u.idUsuario
        WHERE u.idUsuario = ${idUsuario};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function publicar(titulo, categoria, descricao, idUsuario, url) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function publicar(): ", titulo, descricao, idUsuario);
    var instrucaoSql = `
        INSERT INTO posts (titulo, categoria,descricao, url, fk_usuario, criado_em) VALUES ('${titulo}', '${categoria}','${descricao}', '${url}', ${idUsuario}, CURDATE());
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}




function buscarGraficoWeek(idUsuario) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function publicar(): ", idUsuario);

    var instrucaoSql = `
SELECT 
    DAYNAME(criado_em) AS dia_semana,
    COUNT(*) AS quantidade_posts
FROM posts
 WHERE 
    fk_usuario = ${idUsuario} and criado_em >= NOW() - INTERVAL 7 DAY
GROUP BY dia_semana;



    `
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarGraficoCategoria(idUsuario) {
    console.log("ACESSEI O GRAFICO categorias", idUsuario);

    var instrucaoSql = `SELECT 
    u.nome AS usuario,
    p.categoria,
    COUNT(p.idPost) AS total_posts
FROM posts p
JOIN usuario u ON p.fk_usuario = u.idUsuario
WHERE u.idUsuario = ${idUsuario} 
GROUP BY u.idUsuario, p.categoria
ORDER BY total_posts DESC;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



module.exports = {
    listar,
    listarPorUsuario,
    pesquisarDescricao,
    publicar,
    contarCategoria,
    buscarGraficoWeek,
    buscarGraficoCategoria
}

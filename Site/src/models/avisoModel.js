var database = require("../database/config");

function listar() {
    console.log("ACESSEI O posts  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
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

function pesquisarDescricao(texto) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function pesquisarDescricao()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
            a.descricao,
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
        WHERE a.descricao LIKE '${texto}' order by a.criado_em desc;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function listarPorUsuario(idUsuario) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listarPorUsuario()");
    var instrucaoSql = `
        SELECT 
            a.idPost AS idposts,
            a.titulo,
            a.descricao,
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

function publicar(titulo, descricao, idUsuario, url) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function publicar(): ", titulo, descricao, idUsuario);
    var instrucaoSql = `
        INSERT INTO posts (titulo, descricao, url, fk_usuario, criado_em) VALUES ('${titulo}', '${descricao}', '${url}', ${idUsuario}, default);
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function editar(novaDescricao, idposts) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function editar(): ", novaDescricao, idposts);
    var instrucaoSql = `
        UPDATE posts SET descricao = '${novaDescricao}' WHERE id = ${idposts};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function deletar(idposts) {
    console.log("ACESSEI O posts MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function deletar():", idposts);
    var instrucaoSql = `
        DELETE FROM posts WHERE id = ${idposts};
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
    listarPorUsuario,
    pesquisarDescricao,
    publicar,
    editar,
    deletar
}

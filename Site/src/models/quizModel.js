const database = require("../database/config");

// dashboard
function buscarMetricas() {
    console.log("ACESSEI O QUIZ  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function buscarMetricas()");
    var instrucaoSql = `

SELECT 
    r.idResultado,
    u.nome AS nome,
    r.totalAcertos AS acertos,
    r.totalErros AS erros,
    t.dataHora AS inicio,
    (SELECT COUNT(*) FROM questoes WHERE fkQuiz = q.idQuiz) AS qtd_questoes,
    r.dataHoraFim AS fim,
    DATE(r.dataHoraFim) AS data_fim,
    SEC_TO_TIME(TIMESTAMPDIFF(SECOND, t.dataHora, r.dataHoraFim)) AS tempo
FROM Tentativas AS t
JOIN usuario AS u ON t.fkUsuario = u.idUsuario
JOIN resultado AS r ON r.fkTentativa = t.idTentativa
JOIN quiz AS q ON t.fkQuiz = q.idQuiz
where u.idUsuario = 1;

    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// fim dash

function buscarQuestoes() {
    console.log("ACESSEI O QUIZ  MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function listar()");
    var instrucaoSql = `
       SELECT * FROM questoes
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function registrarTentativa(totalAcertos, totalErros) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", totalAcertos, totalErros);

    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `    
        INSERT INTO Resultado (fkTentativa, totalAcertos, totalErros, dataHoraFim ) VALUES (1, '${totalAcertos}', '${totalErros}', NOW());
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

// Coloque os mesmos parâmetros aqui. Vá para a var instrucaoSql
function iniciarQuiz(idUsuario) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():", idUsuario);

    // Insira exatamente a query do banco aqui, lembrando da nomenclatura exata nos valores
    //  e na ordem de inserção dos dados.
    var instrucaoSql = `    
       INSERT INTO Tentativas (fkUsuario, fkQuiz, dataHora) VALUES (${idUsuario}, 1, NOW());`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarQuestoes, registrarTentativa, iniciarQuiz, buscarMetricas
}


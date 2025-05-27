var quizModel = require('../models/quizModel');

// dash
function buscarMetricas(req, res) {
    var idUsuario = req.params.idUsuario;

    quizModel.buscarMetricas(idUsuario)
        .then(function (resultados) {

            console.log(resultados + " FOI! =D")

            if (!resultados) {
                return res.status(500).json({ erro: 'Não foi possível recuperar as métricas.' });
            }
            return res.status(200).json(resultados);
        })

        .catch(function (err) {
            return res.status(500).json({ erro: err.message });
        });


};


// fim dash
function buscarQuestoes(req, res) {
    quizModel.buscarQuestoes()
        .then(function (resultados) {

            console.log(resultados + " FOI! =D")

            if (!resultados) {
                return res.status(500).json({ erro: 'Não foi possível recuperar as questões.' });
            }
            return res.status(200).json(resultados);
        })

        .catch(function (err) {
            return res.status(500).json({ erro: err.message });
        });
};


function buscarFK(req, res) {
    var idUsuario = req.params.id;

    quizModel.buscarTentativaFK(idUsuario)
        .then(function (resultadoFK) {

            console.log(resultadoFK[0].idTentativa + " FOI! =D");

            if (!resultadoFK) {
                return res.status(500).json({ erro: 'Não foi possível recuperar a FK.' });
            }
            return res.status(200).json(resultadoFK);
        })

        .catch(function (err) {
            return res.status(500).json({ erro: err.message });
        });
};



function registrarTentativa(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var idUsuario = req.params.id;
    var totalAcertos = req.body.acertosServer;
    var totalErros = req.body.errosServer;
    var tentativaFK = req.body.tentativaServer;
    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    quizModel.registrarTentativa(idUsuario, totalAcertos, totalErros, tentativaFK)
        .then((resultado) => {
            res.status(200).json(resultado);
        }).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar a tentiva! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
};

function iniciarQuiz(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var idUsuario = req.params.id;
    // Passe os valores como parâmetro e vá para o arquivo usuarioModel.js
    quizModel.iniciarQuiz(idUsuario)
        .then((resultado) => {
            res.status(200).json(resultado);
        }).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar a tentiva! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
};





module.exports = {
    buscarQuestoes, registrarTentativa, iniciarQuiz, buscarMetricas, buscarFK
};
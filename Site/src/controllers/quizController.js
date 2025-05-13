var quizModel = require('../models/quizModel');

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

module.exports = {
    buscarQuestoes
};
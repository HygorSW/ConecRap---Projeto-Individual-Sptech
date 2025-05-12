const express = require('express');
const router = express.Router();

const quizController = require('../controllers/quizController');

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/questoes", function (req, res) {
    quizController.buscarTodas(req, res);
})


module.exports = router;


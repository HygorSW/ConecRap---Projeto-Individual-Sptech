const express = require('express');
const router = express.Router();

const quizController = require('../controllers/quizController');

//dashboard
router.get("/dashboard/:idUsuario", function (req, res) {
    quizController.buscarMetricas(req, res);
})



//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.get("/questoes", function (req, res) {
    quizController.buscarQuestoes(req, res);
})

//Recebendo os dados do html e direcionando para a função buscarFK de quizController.js
router.get("/fk/:id", function (req, res) {
    quizController.buscarFK(req, res);
})


// Rota para registrar uma tentativa de quiz
router.post("/tentativa/:id", function (req, res) {
    quizController.registrarTentativa(req, res);
});

// Rota para registrar uma tentativa de quiz
router.post("/inicio/:id", function (req, res) {
    quizController.iniciarQuiz(req, res);
});




module.exports = router;


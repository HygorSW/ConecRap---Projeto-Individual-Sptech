var express = require("express");
var router = express.Router();

var avisoController = require("../controllers/avisoController");

router.get("/listar", function (req, res) {
    avisoController.listar(req, res);
});

router.get("/categoria/:idUsuario", function (req, res) {
    avisoController.contarCategoria(req, res);
});


router.get("/listar/:idUsuario", function (req, res) {
    avisoController.listarPorUsuario(req, res);
});

router.get("/pesquisar/:descricao", function (req, res) {
    avisoController.pesquisarDescricao(req, res);
});

router.post("/publicar/:idUsuario", function (req, res) {
    avisoController.publicar(req, res);
});

router.get("/week/:idUsuario", function (req, res) {
    avisoController.buscarGraficoWeek(req, res);
});

router.get("/graficoCategorias/:idUsuario", function (req, res) {
    avisoController.buscarGraficoCategoria(req, res);
});




module.exports = router; 
const express = require('express');
const router = express.Router();

const { controller } = require("../controllers/controller");

//Se crea clase Controller y se llaman a los métodos de esa clase
var rep = new SimulacionReportesCont();

module.exports = router;
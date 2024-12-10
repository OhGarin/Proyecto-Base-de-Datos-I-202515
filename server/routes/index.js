const express = require("express");
const router = express.Router();

const { controllerSql } = require("../controllers/controller");

router.post("/sql", controllerSql);

module.exports = router;

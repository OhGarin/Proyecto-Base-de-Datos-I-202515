const { database } = require("../config/dbconfig");

const controllerSql = (req, res) => {
  const { query } = req.body;
  database.query(query, (err, result) => {
    if (err) {
      res.status(500).send({ message: "Error in query", err });
      return;
    }
    res.status(200).send({
      count: result.rowCount,
      rows: result.rows,
    });
  });
};

module.exports = { controllerSql };

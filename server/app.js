const express = require("express");
const cors = require("cors");

//instancia app para configar servidor, definir rutas, manejar solicitudes, etc
const app = express();
//si no esta definida en .env usara el puerto 3000
const port = process.env.PORT || 3000;

//middleware para parsear solicitudes json recibidos desde cliente
app.use(express.json());
// Habilita CORS para permitir solicitudes desde otros orígenes
app.use(cors());
//Habilita uso de rutas definidas
app.use("/", require("./routes"));

//inicializacion del server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});

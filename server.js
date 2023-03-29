import express from 'express';
import mongoose from 'mongoose';
import morgan from 'morgan'; // Importer morgan
import cors from 'cors'; // Importer cors
import path from "path";

import { notFoundError, errorHandler } from './middlewares/error-handler.js';

import userRoutes from './Routes/User.js';


const app = express();
const port = process.env.PORT || 9090;
const databaseName = 'PIM';

mongoose.set('debug', true);
mongoose.Promise = global.Promise;
mongoose.connect(
  "mongodb://localhost:27017/PIM",

  {
    authSource: "admin",
    user: "admin",
    pass: "password",
    useNewUrlParser: true,
    useUnifiedTopology: true,
  }
);
app.use(cors()); // Utiliser CORS
app.use(morgan('dev')); // Utiliser morgan
app.use(express.json()); // Pour analyser application/json
app.use(express.urlencoded({ extended: true })); // Pour analyser application/x-www-form-urlencoded
app.use('/img', express.static('public/images')); // Servir les fichiers sous le dossier public/images

// A chaque requête, exécutez ce qui suit
app.use((req, res, next) => {
  console.log("Middleware just ran !");
  next();
});

// Sur toute demande à /gse, exécutez ce qui suit
app.use('/gse', (req, res, next) => {
  console.log("Middleware just ran on a gse route !");
  next();
});

app.use('/user', userRoutes);


// Utiliser le middleware de routes introuvables
app.use(notFoundError);
// Utiliser le middleware gestionnaire d'erreurs
app.use(errorHandler);

app.set("view engine", "ejs");
app.set("views", path.join(process.cwd(), "views"));

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}/`);
});

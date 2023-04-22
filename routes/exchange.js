import express, { Router } from 'express';
 // Importer express-validator

import { Exchange,SendTo} from '../controllers/exchange.js';
import multer from '../middlewares/multer-config.js'; 
//import auth from '../middlewares/uth.js'
const router = express.Router();

router
  .route('/:_id/:coins')
  .get(Exchange);
router
    .route('/:_id/:receiver/:ammount')    
    .post(SendTo);
export default router;
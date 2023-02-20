import express from 'express';
import { addFromFile, generatePack, generatePack2 } from '../controllers/card.js';

const router = express.Router();

router
    .route('').get(addFromFile);
router
    .route('/pack').get(generatePack);
router
    .route('/pack2').get(generatePack2);

export default router;
import mongoose from 'mongoose';
const { Schema, model } = mongoose;
import Stat from '../models/stats.js';

const playerSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    image: {
        type: String,
        required: true
    },
    rating: {
        type: Number,
        required: true
    },
    stats: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Stat'
    }]
});

export default model('Player', playerSchema);

import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const playerSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    balance: {
        type: Number,
        default: 0
    }
});

export default model('User', playerSchema);

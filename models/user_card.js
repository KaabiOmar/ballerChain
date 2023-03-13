import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const playerSchema = new mongoose.Schema({
    card: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Player'
    },
    user: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User'
    }
});

export default model('user_card', playerSchema);

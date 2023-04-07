import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const playerSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    }
});

export default model('User', playerSchema);

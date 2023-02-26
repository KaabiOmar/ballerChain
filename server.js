const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const Web3 = require('web3');
const contract = require('truffle-contract');
const path = require('path');
const mongoose = require('mongoose');

const ganache = require("ganache");
const User = require('./models/user');

// Connect to MongoDB database
mongoose.connect('mongodb://localhost/myapp', { useNewUrlParser: true });
mongoose.connection.on('error', (err) => {
    console.error(`MongoDB connection error: ${err}`);
    process.exit(-1);
});

// Load the smart contract
const contractJSON = require('./blockchain/build/contracts/MyContract.json');
const MyContract = contract(contractJSON);
const provider = new Web3.providers.HttpProvider('http://localhost:7545');

//const web3 = new Web3(provider);
//MyContract.setProvider(provider);



// Set up middleware
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Endpoint to register a new user
app.post('/register', async (req, res) => {
    const { name, email } = req.body;
    MyContract.setProvider(ganache.provider());
    const web3 = new Web3(ganache.provider());
    const accounts = await web3.eth.getAccounts();

    MyContract.deployed().then(function (instance) {
        return instance.register(name, email, { from: accounts[0] });
    }).then(function (result) {
        const user = new User({ name, email });
        user.save((err) => {
            if (err) {
                console.error(`Error saving user to MongoDB: ${err}`);
                res.status(500).json({ error: 'Error saving user to database' });
            } else {
                res.status(200).json({ message: 'User registered successfully' });
            }
        });
    }).catch(function (err) {
        console.error(`Error registering user on blockchain: ${err}`);
        res.status(500).json({ error: 'Error registering user on blockchain' });
    });
});

// Start the server
const port = 3000;
app.listen(port, () => console.log(`Server running on port ${port}`));

require('dotenv').config()

const express = require('express');

const jwt = require('jsonwebtoken')
const { exec } = require('child_process');

const route = express.Router();

const web3 = require('web3');
const VaultCoinArtifact = require('../../build/contracts/VaultCoin.json');
const Tx = require('ethereumjs-tx').Transaction;

const getBalance = async (req,res,next)  => {
  web3js = new web3(new web3.providers.HttpProvider(
    "http://localhost:7545"
  ));
  var meta=null;
  const networkId = await web3js.eth.net.getId();
  const deployedNetwork = VaultCoinArtifact.networks[networkId];
  
  meta = new web3js.eth.Contract(
      VaultCoinArtifact.abi,
      deployedNetwork.address,
  );

  const { balanceOf } = meta.methods;
  const balance = await balanceOf(req.body.account).call();
  console.log(balance);

  const parsedBalance = parseFloat(web3.utils.fromWei(balance, "ether")).toFixed(2);
  res.status(200).send(JSON.stringify(
      {
        balance:balance,
        balanceVaultWei:parsedBalance.toString(),
      }
    )
  )

}

const sendCoin = async (req,res,next)  => {
  web3js = new web3(new web3.providers.HttpProvider("http://localhost:7545"));
  var meta=null;
  const networkId = await web3js.eth.net.getId();
  //console.log(networkId);
  const deployedNetwork = VaultCoinArtifact.networks[networkId];
  
  meta = new web3js.eth.Contract(
      VaultCoinArtifact.abi,
      deployedNetwork.address,
  );

  const { transfer } = meta.methods;
  const { balanceOf } = meta.methods;

  const privateKey1 = '0x8f6c4d1c6ad4bcdf12edb7225f1a60fbebe7f17dfe6ac5624cb558ea961a5c75'
  const privateKey1Buffer = Buffer.from(privateKey1.slice(2), 'hex');

  //console.log(privateKey1Buffer);
    //console.log(req.body.receiver);
   // console.log(req.body.account);

  const gasPrice = 20000000000;
  const gasPriceHex = web3js.utils.toHex(gasPrice);
  const BN = web3js.utils.BN;
  const amount = web3js.utils.toWei('1', 'ether');
  const value = '0x' + new BN(amount).toString('hex');
 // console.log(value);
 

  function sendRaw(rawTx) {
    var privateKey = new Buffer.from(privateKey1.slice(2), 'hex');
        
    var transaction = new Tx(rawTx);
    try{
      transaction.sign(privateKey);
      console.log('succse signing transaction:');
    }catch(error){
      console.log('Error signing transaction: ', error.message);
    }
    var serializedTx = transaction.serialize().toString('hex');
    console.log('v value:', '0x' + serializedTx.slice(0, 2).toString('hex'));
    web3js.eth.sendSignedTransaction(
        '0x' + serializedTx, function(err, result) {
            if(err) {
                console.log('error');
                console.log(err);
                console.log('Stack trace:', err.stack);
            } else {
                console.log('success');
                console.log(result);
            }
              // Call TransactionChecker after successful transaction
        const txChecker = new TransactionChecker(req.body.receiver);
        txChecker.checkBlock();
        });
}
//console.log("transactions:" +web3js.eth.getTransactionCount(req.body.receiver));
/*const txObject = await web3js.eth.getTransaction(rawTx);

if (txObject == null) {
    console.log("Transaction not found or not confirmed yet");
    return;
}

const vValue = txObject.v;
console.log(vValue);*/


var rawTx = {
  nonce: web3js.utils.toHex(web3js.eth.getTransactionCount(req.body.receiver)),
  gasPrice: gasPriceHex,
  gasLimit: web3.utils.toHex(6721975),
  to: req.body.receiver,
  from: req.body.account,
  value: value

}
sendRaw(rawTx);
console.log(rawTx);

  const balance = await balanceOf(req.body.receiver).call();
  
  res.status(200).send(JSON.stringify(
      {
        balance:balance
      }
    )
  )

}



const getTransactionHistory = async (req,res,next) => {
  web3js = new web3(new web3.providers.HttpProvider(
    "http://localhost:7545"
  ));
  var meta=null;
  const networkId = await web3js.eth.net.getId();
  const deployedNetwork = VaultCoinArtifact.networks[networkId];
  
  meta = new web3js.eth.Contract(
      VaultCoinArtifact.abi,
      deployedNetwork.address,
  );

  meta.getPastEvents("allEvents",{
    fromBlock: 0,
    toBlock: 'latest'
  }).then(function(events){
    var transactions=[];
    let account = req.body.account;
    for (let i = 0; i < events.length; i++) {
      if (( account == events[i].returnValues.from) || (account == events[i].returnValues.to)) {

        const amount = parseInt(events[i].returnValues.tokens);
        const convertedAmount = amount/1000000000000000000;
        
        transactions.push({
          from:events[i].returnValues.from,
          to:events[i].returnValues.to,
          tokens:convertedAmount.toString(),
        });
      }
    }

    res.json(transactions.reverse())
    
  })
}

/*const generateSeedPhrase = async (req,res,next) => {
  const privatekey = "0x8f6c4d1c6ad4bcdf12edb7225f1a60fbebe7f17dfe6ac5624cb558ea961a5c75"; 
  const commmand = 'echo -n "'+privatekey+'" | ./bx-linux-x64-qrcode base16-encode | ./bx-linux-x64-qrcode sha256 | cut -c 1-32 | ./bx-linux-x64-qrcode  mnemonic-new';
  exec(commmand, (err, stdout, stderr) => {
    if (err) {
      console.error(`exec error`,{err});
      return;
    }

    res.json(stdout);
  });
}*/

const bip39 = require('bip39');
const crypto = require('crypto');

const generateSeedPhrase = async (req, res, next) => {
// Replace the example private key with your own
const privateKey = req.body.privateKey;
// Generate a 32-byte entropy buffer from the private key
const entropyBuffer = crypto.createHash('sha256').update(Buffer.from(privateKey, 'hex')).digest();
// Generate a 12-word seed phrase from the entropy buffer
const seedPhrase = bip39.entropyToMnemonic(entropyBuffer);
return res.send(seedPhrase);
};



const importAccount = async (req,res,next) => {
  web3js = new web3(new web3.providers.HttpProvider(
    "http://localhost:7545"
  ));
  const privateKey = req.body.privatekey;
  //console.log(req.body);
  //console.log(privateKey);
  const account = await web3js.eth.accounts.privateKeyToAccount(privateKey);

  console.log("result :");
  console.log(account);
  res.json({
    account:account['address']

  });
}

const createAccount = async (req,res,next) => {
  console.log("inside create account")
  /*res.json({
    privatekey:"dc999166e40dfde0fe68d2c3e81b1bb11f12f89778f58ed31fd943447c8f8ab6",
    account:"0xEeA09a32C4a4986E198F76493A177aa2e0D67092"
  });*/

  web3js = new web3(new web3.providers.HttpProvider(
    "http://localhost:7545"
  ));

  const account = await web3js.eth.accounts.create();

  res.json({
    privatekey:account['privateKey'],
    account:account['address']
  });
  
}

const getBalanceInEth = async (req,res,next) => {
  web3js = new web3(new web3.providers.HttpProvider(
    "http://localhost:7545"
  ));

  const publicKey = req.body.account;
  web3js.eth.getBalance(publicKey, function(err, result) {
    if (err) {
      console.log(err)
    } else {
      res.status(200).send(JSON.stringify(
        {
          balanceEth:web3.utils.fromWei(result, "ether"),
          balanceEthWei:result,
        }
      ))
    }
  })
}


function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization']
    const token = authHeader && authHeader.split(' ')[1]
    if (token == null) return res.status(401).send(JSON.stringify({msg:"no token in headers"}))
  
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
      if (err) return res.status(403).send(JSON.stringify({msg:"erreur in token"}))
      req.user = user
      next()
    })
}




//route.get('/',authenticateToken,index)
route.post('/getBalance',getBalance)
route.post('/sendCoin',sendCoin)
route.post('/history',getTransactionHistory)

route.post('/generateSeedPhrase',generateSeedPhrase)
route.post('/importAccount',importAccount)
route.post('/getBalanceInEth',getBalanceInEth)
route.post('/createAccount',createAccount)


module.exports = route;
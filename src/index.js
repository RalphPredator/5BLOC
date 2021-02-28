const abi = require("./abi.js")

var cryptoToken;
var userAccount;
var web3js;

function startApp() {
  var cryptoTokenAddress = "0x8d50847875d4Bf9C899AfBf15d4005B9085542cb";
    console.log("okokokokokok")
  cryptoToken = new web3js.eth.Contract(abi,cryptoTokenAddress);
  var accountInterval = setInterval(function() {
    // Check if account has changed
    if (web3.eth.accounts[0] !== userAccount) {
      userAccount = web3.eth.accounts[0];
      // Call a function to update the UI with the new account
      getTokensByOwner(userAccount)
      .then(displayTokens);
    }
  }, 100);

  // Start here
  cryptoToken.events.Transfer({ filter: { _to: userAccount } })
  .on("data", function(event) {
    let data = event.returnValues;
    getTokensByOwner(userAccount).then(displayTokens);
  }).on("error", console.error);
}

function displayTokens(ids) {
  $("#zombies").empty();
  for (id of ids) {
    // Look up zombie details from our contract. Returns a `zombie` object
    getTokenDetails(id)
    .then(function(zombie) {
      // Using ES6's "template literals" to inject variables into the HTML.
      // Append each one to our #zombies div
      $("#zombies").append(`<div class="zombie">
        <ul>
          <li>Name: ${zombie.name}</li>
          <li>DNA: ${zombie.dna}</li>
          <li>Level: ${zombie.level}</li>
          <li>Wins: ${zombie.winCount}</li>
          <li>Losses: ${zombie.lossCount}</li>
          <li>Ready Time: ${zombie.readyTime}</li>
        </ul>
      </div>`);
    });
  }
}

function createToken() {
  // This is going to take a while, so update the UI to let the user know
  // the transaction has been sent
  $("#txStatus").text("Creating new zombie on the blockchain. This may take a while...");
  // Send the tx to our contract:
  return cryptoToken.methods.createRandomZombie(name)
  .send({ from: userAccount })
  .on("receipt", function(receipt) {
    $("#txStatus").text("Successfully created " + name + "!");
    // Transaction was accepted into the blockchain, let's redraw the UI
    getTokensByOwner(userAccount).then(displayTokens);
  })
  .on("error", function(error) {
    // Do something to alert the user their transaction has failed
    $("#txStatus").text(error);
  });
}

function levelUp(zombieId) {
  $("#txStatus").text("Leveling up your zombie...");
  return cryptoToken.methods.levelUp(zombieId)
  .send({ from: userAccount, value: web3.utils.toWei("0.001", "ether") })
  .on("receipt", function(receipt) {
    $("#txStatus").text("Power overwhelming! Zombie successfully leveled up");
  })
  .on("error", function(error) {
    $("#txStatus").text(error);
  });
}

function getTokenDetails(id) {
  return cryptoToken.methods.zombies(id).call()
}

function tokenToOwner(id) {
  return cryptoToken.methods.tokenToOwner(id).call()
}

function getTokensByOwner(owner) {
  return cryptoToken.methods.getTokensByOwner(owner).call()
}

window.addEventListener('load', function() {

  // Checking if Web3 has been injected by the browser (Mist/MetaMask)
  if (typeof web3 !== 'undefined') {
    // Use Mist/MetaMask's provider
    web3js = new Web3(web3.currentProvider);
    console.log("okok")
  } else {
    // Handle the case where the user doesn't have MetaMask installed
    // Probably show them a message prompting them to install MetaMask
    web3js = new Web3(new Web3.providers.HttpProvider('http://localhost:7545'));
  }

  // Now you can start your app & access web3 freely:
  startApp()

})
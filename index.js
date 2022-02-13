import Web3 from './node_modules/web3'
// var Web3 = require("web3")
var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"))
var account;

var abi = JSON.parse('[{"inputs":[{"internalType":"bytes32[]","name":"candidateList","type":"bytes32[]"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"candidates","outputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"candidate","type":"bytes32"}],"name":"getCanditeNumberOfVotes","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"candidate","type":"bytes32"}],"name":"validCandidate","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"","type":"bytes32"}],"name":"voteRecived","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"bytes32","name":"candidate","type":"bytes32"}],"name":"votingForCandidate","outputs":[],"stateMutability":"nonpayable","type":"function"}]')
var VotingContract = web3.eth.contract(abi);

var contractInstance = VotingContract.at('0xeeac5d8c9c6a77a36226a081b67d1ccf22c07276');

var candidates = {"Jungkook": "candidate-1", "Jimin": "candidate-2", "Jin": "candidate-3", "V": "candidate-4", "RM": "candidate-5", "Suga": "candidate-6", "JHope": "candidate-7"}

$(document).ready(function() {
  mainWindow = new BrowserWindow({
      webPreferences: {
          nodeIntegration: true,
          contextIsolation: false,
      }
  });

  function voteForCandidate() {
    candidateName = $("#candidate").val();
  
    contractInstance.votingForCandidate(candidateName, {from: account, gas: 4700000}, function() {
      let div_id = candidates[candidateName];
      $("#" + div_id).html(contractInstance.getCanditeNumberOfVotes.call(candidateName).toString());
    });
  }

  web3.eth.getAccounts((err, accs) => {
  if (err != null) {
  alert('There was an error fetching your accounts.')
  return
  }

  if (accs.length === 0) {
  alert("Couldn't get any accounts! Make sure your Ethereum client is configured correctly.")
  return
  }

  account = accs[0]

  })

  candidateNames = Object.keys(candidates);
  
  candidateNames.forEach(name => {
    const count = contractInstance.getCanditeNumberOfVotes.call(name).toNumber();
    $("#" + candidates[name]).html(val);
  })

});
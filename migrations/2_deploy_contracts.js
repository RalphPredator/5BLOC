var tokenfactory = artifacts.require("../contracts/tokenfactory.sol");
var tokenhelper = artifacts.require("../contracts/tokenhelper.sol");
var tokenownership = artifacts.require("../contracts/tokenownership.sol");

module.exports = function(deployer) {

  deployer.deploy(tokenfactory);
  deployer.link(tokenfactory, tokenhelper);

  deployer.deploy(tokenhelper);
  
  deployer.link(tokenhelper, tokenownership);

  deployer.deploy(tokenownership);
};
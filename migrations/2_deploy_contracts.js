var safemath = artifacts.require("./safemath.sol");
var tokenfactory = artifacts.require("./tokenfactory.sol");
var tokenhelper = artifacts.require("./tokenhelper.sol");
var tokenownership = artifacts.require("./tokenownership.sol");

module.exports = function(deployer) {


  deployer.deploy(tokenfactory);
  deployer.link(tokenfactory, tokenhelper);

  deployer.deploy(tokenhelper);
  
  deployer.link(tokenhelper, tokenownership);

  deployer.deploy(tokenownership);

  deployer.deploy(safemath);
};
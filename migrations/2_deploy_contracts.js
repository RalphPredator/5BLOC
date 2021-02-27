var erc721 = artifacts.require("./erc721.sol");
var ownable = artifacts.require("./ownable.sol");
var safemath = artifacts.require("./safemath.sol");
var tokenfactory = artifacts.require("./tokenfactory.sol");
var tokenhelper = artifacts.require("./tokenhelper.sol");
var tokenownership = artifacts.require("./tokenownership.sol");

module.exports = function(deployer) {

  deployer.deploy(ownable);
  deployer.link(ownable, tokenfactory);

  deployer.deploy(tokenfactory);
  deployer.link(tokenfactory, tokenhelper);

  deployer.deploy(tokenhelper);
  deployer.deploy(erc721);
  deployer.link(erc721, tokenownership);
  deployer.link(tokenhelper, tokenownership);

  deployer.deploy(tokenownership);

  deployer.deploy(safemath);
};
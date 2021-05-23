const EscrowFactoryContract = artifacts.require("EscrowFactory");
const CoinX = artifacts.require("CoinX");
const CoinY = artifacts.require("CoinY");

module.exports = function (deployer) {
  deployer.deploy(EscrowFactoryContract);
  deployer.deploy(CoinX, 88888888888);
  deployer.deploy(CoinY, 99999999999);
};


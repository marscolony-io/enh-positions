const Placement = artifacts.require("GetCoords");

module.exports = function (deployer, network, accounts) {
  console.log(accounts)
  deployer.deploy(Placement, network == "hartest" ? "0xc65F8BA708814653EDdCe0e9f75827fe309E29aD": "0x0D112a449D23961d03E906572D8ce861C441D6c3");
};

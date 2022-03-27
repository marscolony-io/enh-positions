const GetCoords = artifacts.require("GetCoords");
const GameManager = artifacts.require("GameManagerMock");

module.exports = async function (deployer, network, accounts) {
  if (network == "development") {
    await deployer.deploy(GameManager)
    await deployer.deploy(GetCoords, GameManager.address)
  } else {
    console.log(accounts)
    await deployer.deploy(GetCoords, network == "hartest" ? "0xc65F8BA708814653EDdCe0e9f75827fe309E29aD": "0x0D112a449D23961d03E906572D8ce861C441D6c3");
  }
};
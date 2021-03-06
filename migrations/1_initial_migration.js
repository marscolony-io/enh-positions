const GetCoords = artifacts.require("GetCoords");
const GetUserData = artifacts.require("GetUserData");
const GameManager = artifacts.require("GameManagerMock");

module.exports = async function (deployer, network, accounts) {
  if (network == "development") {
    await deployer.deploy(GameManager)
    await deployer.deploy(GetCoords, GameManager.address)
  } else {
    // console.log(accounts)
    // await deployer.deploy(GetCoords, network == "hartest" ? "0xc65F8BA708814653EDdCe0e9f75827fe309E29aD": "0x0D112a449D23961d03E906572D8ce861C441D6c3");
    // await deployer.deploy(
    //     GetUserData, 
    //     network == "hartest" ? "0xc65F8BA708814653EDdCe0e9f75827fe309E29aD": "0x0D112a449D23961d03E906572D8ce861C441D6c3", 
    //     network == "hartest" ? "0xc268D8b64ce7DB6Eb8C29562Ae538005Fded299A": "0x0bC0cdFDd36fc411C83221A348230Da5D3DfA89e",
    //     network == "hartest" ? "0xDEfafb07765D9D0F897260BE1389743A09802F20": "0xFDCC01E0Fe5D3Fb11B922447093EE6862685616c",
    //   )
    await deployer.deploy(
      GetCoords, 
      '0xCAFAeD55fEfEd74Ca866fE72D65CfF073eb42797'
    )
  }
};
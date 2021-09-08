// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const TokenFactory = await hre.ethers.getContractFactory("TokenFactory");
  const tokenFactory = await TokenFactory.deploy();
  await tokenFactory.deployed();

  console.log("Token Factory deployed to:", tokenFactory.address);
  const TokenA = { 
    _name: "FungibleToken",
    _symbol: "FT",
    _decimals: 18,
    _initialSupply: 1000000,
    _tokenType: 0
  };
  const createToken = await tokenFactory.createERC20(
    TokenA._name,
    TokenA._symbol,
    TokenA._decimals,
    TokenA._initialSupply,
    TokenA._tokenType
  )
  const receipt = await createToken.wait();
  const output = receipt.events.filter(({event}) => event === "TokenCreated");
  const address = output[0].args['tokenAddress'];
  console.log("createERC20 tokenAddress:",address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

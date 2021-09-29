// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
// const ethers = require("ethers");
const hardhat = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const TokenFactory = await hardhat.ethers.getContractFactory(
    "TokenFactoryERC721"
  );
  const tokenFactory = await TokenFactory.deploy();
  await tokenFactory.deployed();
  console.log("Token Factory deployed to:", tokenFactory.address);
  console.log(
    "Etherscan:",
    process.env.ETHERSCAN_URL + "/address/" + tokenFactory.address
  );

  // const receipt = await createToken.wait();
  // console.log(receipt.address);
  // const output = receipt.events.filter(({ event }) => event === "TokenCreated");
  // const address = output[0].args.tokenAddress;
  // console.log("createERC20 tokenAddress:", address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

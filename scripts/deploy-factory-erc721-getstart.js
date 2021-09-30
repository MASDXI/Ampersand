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

  console.log("Set paused");

  const setPaused = await tokenFactory.setPaused(false);
  const tx1 = await setPaused.wait();
  console.log(
    "Etherscan:",
    process.env.ETHERSCAN_URL + "/tx/" + tx1.transactionHash
  );

  const teamAddress = JSON.parse(process.env.TEAM_ADDRESS);

  console.log("Creacte Token ERC721");

  const token = {
    _name: "name",
    _symbol: "symbol",
    _baseTokenURI: "url",
    _price: hardhat.ethers.utils.parseEther("0"),
    _maxSupply: 888,
    _maxSalePerOrder: 20,
    _teamAddress: teamAddress,
  };

  const createToken = await tokenFactory.createERC721(
    token._name,
    token._symbol,
    token._baseTokenURI,
    token._price,
    token._maxSupply,
    token._maxSalePerOrder,
    token._teamAddress,
    { value: hardhat.ethers.utils.parseEther("0") }
  );
  const tx2 = await createToken.wait();
  console.log(
    "Etherscan:",
    process.env.ETHERSCAN_URL + "/tx/" + tx2.transactionHash
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

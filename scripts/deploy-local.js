const hre = require("hardhat");
const ethers = require("ethers");

async function main() {

  const contract = await hre.ethers.getContractFactory("FactoryClone");
  const FactoryClone = await contract.deploy();
  await FactoryClone.deployed();
  // return contract address
  console.log("Factory Clone deployed to:", FactoryClone.address);
  // create token
  const mockToken = [18,ethers.utils.parseEther("100000000"),"basic coin","bsc"];
  const createToken = await tokenFactory.createToken(mockToken);
  const receipt = await createToken.wait();
  const output = receipt.events.filter(({ event }) => event === "TokenCreated");
  const address = output[0].args.tokenAddress;
  console.log("ERC20 deployed to:", address);
  // testing token
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

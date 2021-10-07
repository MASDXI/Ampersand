const hre = require("hardhat");

async function main() {
  const contractFactory = await hre.ethers.getContractFactory("FactoryClone");
  const factory = await contractFactory.deploy();
  await factory.deployed();
  console.log("TokenFactory address:", factory.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

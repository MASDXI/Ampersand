const hre = require("hardhat");

async function main() {
  const contract = await hre.ethers.getContractFactory("FactoryClone");
  const FactoryClone = await contract.deploy();
  await FactoryClone.deployed();
  // return contract address
  console.log("Factory Clone deployed to:", FactoryClone.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

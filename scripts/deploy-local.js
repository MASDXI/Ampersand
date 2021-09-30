const hre = require("hardhat");

async function main() {
  const contract = await hre.ethers.getContractFactory("FactoryClone");
  const factory = await contract.deploy();

  await factory.deployed();

  console.log("TokenFactory address:", factory.address);
  const createToken = await factory.createToken('Adisak', 'SSSSS', 'url');
  const receipt = await createToken.wait();
  const output = receipt.events[0];
  console.log("createToken address:",output.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
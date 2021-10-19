const hre = require("hardhat");
const fs = require('fs');

async function main() {
  const contract = await hre.ethers.getContractFactory("FactoryClone");
  const FactoryClone = await contract.deploy();
  await FactoryClone.deployed();
  // return contract address
  console.log("Factory Clone deployed to:", FactoryClone.address);
  // write address to file
  let obj = `{\n\  "FactoryAddress\": "${FactoryClone.address}"\n}`
  try {
    const data = fs.writeFileSync('artifacts/deployed.json', obj)
    } catch (err) {
      console.error(err)
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

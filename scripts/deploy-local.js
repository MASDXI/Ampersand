const hre = require("hardhat");

async function main() {
  const accounts = await ethers.getSigners();
  const contractFactory = await hre.ethers.getContractFactory("FactoryClone");
  const factory = await contractFactory.deploy();
  await factory.deployed();
  console.log("TokenFactory address:", factory.address);
  const facy = new ethers.Contract(
    factory.address,
    contractFactory.interface,
    accounts[0]
  );
  const createToken = await facy.createToken(
    [
      "name",
      "symbol",
      "url",
      10000,
      20,
      1,
      [accounts[0].address, accounts[1].address, accounts[2].address],
    ],
    { value: hre.ethers.utils.parseEther("0") }
  );
  const { events } = await createToken.wait();
  const { address } = events.find(Boolean);
  console.log("createToken address:", address);
  const { interface } = await hre.ethers.getContractFactory("ERC721Preset");
  const instance = new ethers.Contract(address, interface, accounts[0]);
  const checkOwner = await instance.hasRole(
    ethers.utils.id("MINTER_ROLE"),
    accounts[0].address
  );
  console.log("ERC721.owner:", checkOwner);
  const checkName = await instance.name();
  console.log("ERC721.name:", checkName);
  const getFactory = await instance.getFactory();
  console.log(getFactory);
  const getFactoryManger = await instance.getFactoryManager();
  console.log(getFactoryManger);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

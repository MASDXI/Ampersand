const hre = require("hardhat");

async function main() {
  // getSigner from remote accounts hardhat test-rpc
  const accounts = await ethers.getSigners();
  const factoryClone = await hre.ethers.getContractFactory("FactoryClone");
  const FactoryClone = await factoryClone.deploy();
  await FactoryClone.deployed();
  console.log("FactoryClone address:", FactoryClone.address);
  const instanceFactory = new ethers.Contract(
    FactoryClone.address,
    factoryClone.interface,
    accounts[0]
  );
  const createToken = await instanceFactory.createToken(
    [
      "nft_name",
      "nft_symbol",
      "nft_uri",
      10000,
      20,
      1,
      [accounts[0].address,accounts[1].address,accounts[2].address]
    ],
    // [string,string,string,uint256,uint256,uint256,address[]]
    { value: hre.ethers.utils.parseEther("0") }
  );
  const { events } = await createToken.wait();
  const { address } = events.find(Boolean);
  console.log("createToken address:", address);
  const { interface } = await hre.ethers.getContractFactory("ERC721Preset");
  const instanceERC721Preset = new ethers.Contract(address, interface, accounts[0]);
  const checkOwner = await instanceERC721Preset.hasRole(
    ethers.utils.id("MINTER_ROLE"),
    accounts[0].address
  );
  console.log("ERC721.owner:", checkOwner);
  const checkName = await instanceERC721Preset.name();
  console.log("ERC721.name:", checkName);
  const getFactory = await instanceERC721Preset.getFactory();
  console.log("getFactory:", getFactory);
  const getFactoryManger = await instanceERC721Preset.getFactoryManager();
  console.log("getFactoryManger:", getFactoryManger);
  console.log(
    "totalSupply before mint",
    (await instanceERC721Preset.totalSupply()).toNumber()
  );
  // await instance.buy(1,{ value: hre.ethers.utils.parseEther("1")});
 const mintting = await instanceERC721Preset.mint(accounts[0].address);
 await mintting.wait();
  console.log(
    "totalSupply after mint",
    (await instanceERC721Preset.totalSupply()).toNumber()
  );
  const getOwnerOf = await instanceERC721Preset.ownerOf(1);
  console.log("mint token ID1 to:", accounts[0].address);
  console.log("ownerOf token ID1:", getOwnerOf);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TokenFactory", function () {

  let token;
  let accounts;
  const amount = ethers.utils.parseEther("1");
  
  // TokenA is ERC20
  const tokenA_address = "0xa16E02E87b7454126E5E10d957A927A7F5B5d2be";
  const TokenA = { 
    _name: "test",
    _symbol: "TKN",
    _decimals: 18,
    _initialSupply: 1000000,
    _tokenType: 0
  };

  // TokenB is ERC721
  // const mockTokenB = <CONTRACT_ADDRESS>
  // const TokenB = { 
  //   _name: "test",
  //   _symbol: "TKN",
  // };

  // // TokenC is ERC1155
  // // const mockTokenC = <CONTRACT_ADDRESS>
  // const TokenC = [];

  before(async () => {
    const contract = await ethers.getContractFactory("TokenFactory");
    token = await contract.deploy();
    accounts = await ethers.getSigners();
    await token.deployed();

  });

  it("CreateERC20 token", async function () {
    // How to retrevie contract address from event 'TokenCreate'
    // first you must uncomment and run test

    // const createToken = await token.createERC20(
    //   TokenA._name,
    //   TokenA._symbol,
    //   TokenA._decimals,
    //   TokenA._initialSupply,
    //   TokenA._tokenType);
    // const receipt = await createToken.wait();
    // const output = receipt.events.filter(({event}) => event === "TokenCreated");
    // const address = output[0].args['tokenAddress'];
    // console.log("tokenAddress:",address);

    await expect(token.createERC20(
      TokenA._name,
      TokenA._symbol,
      TokenA._decimals,
      TokenA._initialSupply,
      TokenA._tokenType
    )).to.emit(token,'TokenCreated').withArgs(tokenA_address);
  });

  it("CreateERC20 token name check ", async function () {
    const _ERC20 = await ethers.getContractFactory("_ERC20");
    const erc20 = _ERC20.attach(tokenA_address); // The deployed contract address
    expect(await erc20.name()).to.equal(TokenA._name);
  });

  // it("CreateERC721 token name check ", async function () {
  //   const _ERC721 = await ethers.getContractFactory("_ERC721");
  //   const erc721 = _ERC721.attach(tokenB_address); // The deployed contract address
  //   expect(await erc721.name()).to.equal(TokenB._name);
  // });

  // it("CreateERC1155 token name check ", async function () {
  //   const _ERC1155 = await ethers.getContractFactory("_ERC1155");
  //   const erc1155 = _ERC1155.attach(tokenB_address); // The deployed contract address
  //   expect(await erc1155.name()).to.equal(TokenC._name);
  // });

});
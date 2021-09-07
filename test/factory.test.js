const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TokenFactory", function () {

  let token;
  let accounts;
  const amount = ethers.utils.parseEther("1")
  
  // TokenA is ERC20
  const mockTokenA = "0xa16E02E87b7454126E5E10d957A927A7F5B5d2be"
  const TokenA = { 
    _name: "test",
    _symbol: "TKN",
    _decimals: 18,
    _initialSupply: 1000000,
    _tokenType: 0
  }

  // TokenB is ERC721
  // const mockTokenB = <CONTRACT_ADDRESS>
  // const TokenB = { 
  //   _name: "test",
  //   _symbol: "TKN",
  //   _initialSupply: 1000000,
  // }
  
  // TokenC is ERC1155
  // const mockTokenC = <CONTRACT_ADDRESS>
  // const TokenC = { 
  //   _name: "test",
  //   _symbol: "TKN",
  //   _decimals: 18,
  //   _initialSupply: 1000000,
  //   _tokenType: 0
  // }

  before(async () => {
    const contract = await ethers.getContractFactory("TokenFactory");
    token = await contract.deploy();
    accounts = await ethers.getSigners();
    await token.deployed();

  });

  it("CreateERC20 token", async function () {
    // How to retrevie contract address from event 'TokenCreate'
    // const createToken = await token.createERC20(
    //   constructor._name,
    //   constructor._symbol,
    //   constructor._decimals,
    //   constructor._initialSupply,
    //   constructor._tokenType);
    // const receipt = await createToken.wait();
    // const output = receipt.events.filter(({event}) => event === "TokenCreated");
    // const address = output[0].args['tokenAddress'];
    // console.log(address);

    await expect(token.createERC20(
      TokenA._name,
      TokenA._symbol,
      TokenA._decimals,
      TokenA._initialSupply,
      TokenA._tokenType
    )).to.emit(token,'TokenCreated').withArgs(mockTokenA);
  });

  it("CreateERC20 token name check ", async function () {
    const _ERC20 = await ethers.getContractFactory("_ERC20");
    const erc20 = _ERC20.attach(mockTokenA); // The deployed contract address
    expect(await erc20.name()).to.equal(constructor._name);
  });

});
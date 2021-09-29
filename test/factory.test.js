const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("TokenFactory", async function () {

  let token;
  let accounts;
  const amount = ethers.utils.parseEther("1");
  
  // TokenA is ERC20
  const tokenA_address = "0xa16E02E87b7454126E5E10d957A927A7F5B5d2be";
  const TokenA = { 
    _name: "FungibleToken",
    _symbol: "FT",
    _decimals: 18,
    _initialSupply: 1000000,
    _tokenType: 0
  };

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
    const contract = await ethers.getContractFactory("_ERC20");
    const token = contract.attach(tokenA_address);
    expect(await token.name()).to.equal(TokenA._name);
  });

  it("capped token mint function should be reverted", async function() {
    const contract = await ethers.getContractFactory("_ERC20");
    const token = contract.attach(tokenA_address);
    const wallet = token.connect(accounts[0]);
    await expect(wallet.mint(
      accounts[0].address,
      amount
    )).to.be.revertedWith('support only uncapped token');
   }); 

});
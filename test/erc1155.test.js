const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ERC721 non fungible token", function () {

  let token;
  let accounts;
  const constructor = {
    _name: "test",
    _symbol: "TKN",
    _initialSupply: 1000000,
  }
  const amount = ethers.utils.parseEther("1")

  before(async () => {
    const contract = await ethers.getContractFactory("_ERC20");
    token = await contract.deploy(
      constructor._name,
      constructor._symbol,
      constructor._decimals,
      constructor._initialSupply,
      constructor._tokenType
    );
    accounts = await ethers.getSigners();
    await token.deployed();

  });

  it("Token name check", async function () {
    expect(await token.name()).to.equal(constructor._name);
  });

  it("Token symbol check", async function () {
    expect(await token.symbol()).to.equal(constructor._symbol);
  });

  // it("Assigns initial balance", async function() {
  //   expect(await token.balanceOf(accounts[0].address)).to.equal(
  //     ethers.utils.parseEther(
  //       constructor._initialSupply.toString()
  //     ));
  // });
  
  // it("capped token mint function should be reverted", async function() {
  //  await expect(token.mint(accounts[0].address,amount)).to.be.revertedWith('support only uncapped token');
  // });

});

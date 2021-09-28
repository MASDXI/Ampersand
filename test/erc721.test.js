const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("ERC721 non fungible token", function () {
  let token;
  let accounts;
  const constructor = {
    _name: "test",
    _symbol: "TKN",
    _initialSupply: 1000000,
  };
  const amount = ethers.utils.parseEther("1");

  before(async () => {
    const contract = await ethers.getContractFactory("_ERC721");
    token = await contract.deploy(constructor._name, constructor._symbol);
    accounts = await ethers.getSigners();
    await token.deployed();
  });

  it("Token name check", async function () {
    expect(await token.name()).to.equal(constructor._name);
  });

  it("Token symbol check", async function () {
    expect(await token.symbol()).to.equal(constructor._symbol);
  });

  it("mint token check", async function () {
    // expect(await token.symbol()).to.equal(constructor._symbol);
  });
});

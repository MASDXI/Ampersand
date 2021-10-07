const { expect, assert } = require("chai");
const { BigNumber } = require("ethers");

describe("FactoryClone test", function () {
  let FactoryClone;
  let ERC721Preset;
  let accounts;
  let tokenInfo;
  let token;
  
  const TOKEN_ADDRESS = "0xB7A5bd0345EF1Cc5E66bf61BdeC17D2461fBd968";

  before(async () => {
    const contract = await ethers.getContractFactory("FactoryClone");
    ERC721Preset = await ethers.getContractFactory("ERC721Preset");
    FactoryClone = await contract.deploy();
    accounts = await ethers.getSigners();
    tokenInfo = ["aaaaaaaaaa", "aaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 10000, 20, 1, [accounts[0].address]];
    await FactoryClone.deployed();
  });

  it("createToken", async function () {
    const result = await FactoryClone.createToken(tokenInfo, {
      value: hre.ethers.utils.parseEther("0"),
    });
    const { events } = await result.wait();
    const { address } = events.find(Boolean);
    token = new ethers.Contract(TOKEN_ADDRESS, ERC721Preset.interface, accounts[0]);
    expect(address).to.equal(TOKEN_ADDRESS);
  });

  it("get Factory fees", async function () {
    const result = await FactoryClone.fees();
    expect(result).to.equal(0);
  });

  it("get Factory feesAddress", async function () {
    const result = await FactoryClone.feesAddress();
    expect(result).to.equal(accounts[0].address);
  });

  it("Factory pause", async function () {
    await FactoryClone.pause();
    const result = await FactoryClone.paused();
    expect(result).to.equal(true);
  });

  it("Factory unpause", async function () {
    await FactoryClone.unpause();
    const result = await FactoryClone.paused();
    expect(result).to.equal(false);
  });

  it("get token name", async function () {
    const result = await token.name();
    expect(result).to.equal(tokenInfo[0]);
  });

  it("get token symbol", async function () {
    const result = await token.symbol();
    expect(result).to.equal(tokenInfo[1]);
  });

  it("get token maxPurchase", async function () {
    const result = await token.maxPurchase();
    expect(result).to.equal(tokenInfo[4]);
  });

  it("get token Price", async function () {
    const result = await token.getPrice();
    expect(result).to.equal(tokenInfo[5]);
  });

  it("minting 1 token", async function () {
    await token.mint(accounts[0].address);
    const result = await token.totalSupply();
    expect(result).to.equal(1);
  });

  it("minting 20 token", async function () {
    await token.mintMulti(accounts[0].address,20);
    const result = await token.totalSupply();
    expect(result).to.equal(21);
  });

});
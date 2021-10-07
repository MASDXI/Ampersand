const { expect, assert } = require("chai");
const { BigNumber } = require("ethers");

describe("ERC721Preset test", function () {
  let ERC721Preset;
  let accounts;
  let TOKEN;

  const DEFAULT_ADMIN_ROLE =
    "0x0000000000000000000000000000000000000000000000000000000000000000";
  const MINTER_ROLE =
    "0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6";
  const PAUSER_ROLE =
    "0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a";
  const DEAFAULT_FACTORY_ADDRESS = "0x0000000000000000000000000000000000000000";

  beforeEach(async () => {
    const contract = await ethers.getContractFactory("ERC721Preset");
    ERC721Preset = await contract.deploy();
    accounts = await ethers.getSigners();
    TOKEN = ["aaaaaaaaaa", "aaaaaaaaaa", "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 10000, 20, 1, [accounts[0].address]];
    await ERC721Preset.deployed();
  });

  it("name", async function () {
    const result = await ERC721Preset.name();
    expect(result).to.equal("");
  });

  it("symbol", async function () {
    const result = await ERC721Preset.symbol();
    expect(result).to.equal("");
  });

  it("DEFAULT_ADMIN_ROLE", async function () {
    const result = await ERC721Preset.DEFAULT_ADMIN_ROLE();
    expect(result.toString()).to.equal(DEFAULT_ADMIN_ROLE);
  });

  it("MINTER_ROLE", async function () {
    const result = await ERC721Preset.MINTER_ROLE();
    expect(result.toString()).to.equal(MINTER_ROLE);
  });

  it("PAUSER_ROLE", async function () {
    const result = await ERC721Preset.PAUSER_ROLE();
    expect(result.toString()).to.equal(PAUSER_ROLE);
  });

  it("balanceOf", async function () {
    const result = await ERC721Preset.balanceOf(accounts[0].address);
    expect(result.toString()).to.equal("0");
  });

  it("getFactory", async function () {
    const result = await ERC721Preset.getFactory();
    expect(result.toString()).to.equal(DEAFAULT_FACTORY_ADDRESS);
  });

  it("getPrice", async function () {
    const result = await ERC721Preset.getPrice();
    expect(result.toString()).to.equal("0");
  });

  it("hasRole", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    const result = await ERC721Preset.hasRole(MINTER_ROLE, accounts[0].address);
    expect(result).to.equal(true);
  });

  it("getRoleCount DEFAULT_ADMIN_ROLE", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    const result = await ERC721Preset.getRoleMemberCount(DEFAULT_ADMIN_ROLE);
    expect(result).to.equal(1);
  });

  it("getRoleCount MINTER_ROLE", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    const result = await ERC721Preset.getRoleMemberCount(MINTER_ROLE);
    expect(result).to.equal(1);
  });

  it("getRoleCount PAUSER_ROLE", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    const result = await ERC721Preset.getRoleMemberCount(PAUSER_ROLE);
    expect(result).to.equal(1);
  });

  it("paused ", async function () {
    const result = await ERC721Preset.paused();
    expect(result).to.equal(false);
  });

  it("minting to accounts[0]", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    await ERC721Preset.mint(accounts[0].address);
    const result = await ERC721Preset.ownerOf(1);
    expect(result).to.equal(accounts[0].address);
  });

  it("buying 20 with accounts[0]", async function () {
    await ERC721Preset.initialize(TOKEN, accounts[0].address);
    await ERC721Preset.buy(20, { value: hre.ethers.utils.parseEther("0.00000000000000002") });
    const array = [];
    for (i = 0; i < 20; i++) {
      array.push(await ERC721Preset.ownerOf(1));
      expect(array[i]).to.equal(accounts[0].address);
    }
  });

  //  it("getFactoryManager", async function() {
  //     const result = await ERC721Preset.getFactoryManager();
  //     expect(result.toString()).to.equal(accounts[0].address);
  //   });
});

const { expect, assert } = require("chai");
const { BigNumber } = require("ethers");

describe("ERC20Preset test", function () {
  let ERC20Preset;
  let accounts;
  let TOKEN;

  const DEFAULT_ADMIN_ROLE =
    "0x0000000000000000000000000000000000000000000000000000000000000000";
  const MINTER_ROLE =
    "0x9f2df0fed2c77648de5860a4cc508cd0818c85b8b8a1ab4ceeef8d981c8956a6";
  const PAUSER_ROLE =
    "0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a";

  beforeEach(async () => {
    const contract = await ethers.getContractFactory("ERC20Preset");
    ERC20Preset = await contract.deploy();
    accounts = await ethers.getSigners();
    TOKEN = [18, hre.ethers.utils.parseEther("1000"), "aaa", "aaa"];
    await ERC20Preset.deployed();
  });

  it("name", async function () {
    await ERC20Preset.initialize(TOKEN,accounts[0].address);
    const result = await ERC20Preset.name();
    expect(result).to.equal("aaa");
  });

  it("symbol", async function () {
    await ERC20Preset.initialize(TOKEN,accounts[0].address);
    const result = await ERC20Preset.symbol();
    expect(result).to.equal("aaa");
  });

  it("DEFAULT_ADMIN_ROLE", async function () {
    const result = await ERC20Preset.DEFAULT_ADMIN_ROLE();
    expect(result.toString()).to.equal(DEFAULT_ADMIN_ROLE);
  });

  it("MINTER_ROLE", async function () {
    const result = await ERC20Preset.MINTER_ROLE();
    expect(result.toString()).to.equal(MINTER_ROLE);
  });

  it("PAUSER_ROLE", async function () {
    const result = await ERC20Preset.PAUSER_ROLE();
    expect(result.toString()).to.equal(PAUSER_ROLE);
  });

  it("balanceOf", async function () {
    await ERC20Preset.initialize(TOKEN,accounts[0].address);
    const result = await ERC20Preset.balanceOf(accounts[0].address);
    expect(ethers.utils.formatEther(result.toString())).to.equal("1000.0");
  });
});
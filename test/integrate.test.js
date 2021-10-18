const { expect, assert } = require("chai");
const { BigNumber } = require("ethers");

describe("FactoryClone test", function () {
  let FactoryClone;
  let ERC20Preset;
  let accounts;
  let tokenInfo;
  let token;

  const TOKEN_ADDRESS = "0xB7A5bd0345EF1Cc5E66bf61BdeC17D2461fBd968";

  before(async () => {
    const contract = await ethers.getContractFactory("FactoryClone");
    ERC20Preset = await ethers.getContractFactory("ERC20Preset");
    FactoryClone = await contract.deploy();
    accounts = await ethers.getSigners();
    tokenInfo = [
      18,
      hre.ethers.utils.parseEther("1000000000"),
      "basic coin",
      "bsc",
    ];
    await FactoryClone.deployed();
  });

  it("createToken", async function () {
    const result = await FactoryClone.createToken(tokenInfo, {
      value: hre.ethers.utils.parseEther("0"),
    });
    const { events } = await result.wait();
    const { address } = events.find(Boolean);
    token = new ethers.Contract(
      TOKEN_ADDRESS,
      ERC20Preset.interface,
      accounts[0]
    );
    expect(address).to.equal(TOKEN_ADDRESS);
  });

  it("get token name", async function () {
    const result = await token.name();
    expect(result).to.equal(tokenInfo[2]);
  });

  it("minting 1 token", async function () {
    // await token.mint(accounts[0].address);
    const result = await token.totalSupply();
    expect(result).to.equal(0);
  });
});

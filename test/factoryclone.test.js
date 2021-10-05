const { expect, assert  } = require("chai");
const { BigNumber } = require("ethers");

describe("ERC721Preset test", function() {
  
  let ERC721Preset;
  let accounts;
  let TOKEN
  
  const TOKEN_ADDRESS = '0xB7A5bd0345EF1Cc5E66bf61BdeC17D2461fBd968'

  beforeEach(async () => {
    const contract = await ethers.getContractFactory("FactoryClone");
    ERC721Preset = await contract.deploy();
    accounts = await ethers.getSigners();
    TOKEN = ["name","symbol","uri",10000,20,1,[accounts[0].address]];
    await ERC721Preset.deployed();
  });

  it("createToken", async function() {
    const result = await ERC721Preset.createToken(TOKEN,{ value: hre.ethers.utils.parseEther("0") });
    const { events } = await result.wait()
    const { address } = events.find(Boolean);
    expect(address).to.equal(TOKEN_ADDRESS);
  });

});
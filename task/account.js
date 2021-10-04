const { task } = require("hardhat/config");

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log("address :", account.address);
  }
});

task("test-com", "Prints the list of accounts", async () => {
  const hre = require("hardhat");
  await hre.run("compile");
});

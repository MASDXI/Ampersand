// eslint-disable-next-line node/no-unpublished-require
const ethers = require("ethers");

const teamAddress = JSON.parse(process.env.TEAM_ADDRESS);

module.exports = [
  "name",
  "symbol",
  "url",
  ethers.utils.parseEther("0"),
  888,
  20,
  teamAddress,
];

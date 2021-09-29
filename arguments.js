// eslint-disable-next-line node/no-unpublished-require
const ethers = require("ethers");

const teamAddress = JSON.parse(process.env.TEAM_ADDRESS);

module.exports = [
  "name",
  "symbol",
  "url",
  ethers.utils.parseEther("1"),
  888,
  20,
  ["0x652bdd352F620876A1C98d8d59DDf2Fa5cf08a36"],
];

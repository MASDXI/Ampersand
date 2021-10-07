# 🔣 Ampersand

### About Ampersand

Ampersand focusing to develop smart contract that robustness cheap and easy for everyone!

### ERC721

Ampersand provide user can create their own ERC721 Token without any single line of code with preset of functionality that's really needed with cheaper transaction fees.

| Contract      |   Gas used | Transaction fee (ETH) |
| :------------ | ---------: | --------------------: |
| FactoryNaive  | ~3,119,849 |        ~0.1559925 ETH |
| FactoryClone  | ~3,710,122 |        ~0.1855061 ETH |
| ERC721Default | ~2,489,577 |        ~0.1244788 ETH |
| ERC721Naive   | ~3,376,344 |        ~0.1688172 ETH |
| ERC721        |   ~697,796 |        ~0.0348898 ETH |

reduce around 70% of gas used

##### \*\* gas price in table is 50 gwei

## Required Software

- node [Download](https://nodejs.org/en/)
- nvm [Download](https://github.com/nvm-sh/nvm#installing-and-updating)
- git [Download](https://git-scm.com/)

clone repository

```shell
git clone https://github.com/MASDXI/TokenFactory.git
```

If you don't have a yarn. Install yarn by the command below.

```shell
npm install --global yarn
```

for installing dependencies with yarn using command.

```shell
yarn install
```

Project directory structure

```
.
├── contracts
│   ├── ERC721Preset.sol
│   ├── IFactoryClone.sol
│   └── FactoryClone.sol
├── docs
│   └── ERC20.md
├── hardhat.config.js
├── LICENSE
├── package.json
├── package-lock.json
├── README.md
├── scripts
│   ├── deploy-local.sol
│   ├── deploy-testnet.sol
│   └── deploy-mainet.js
├── test
│   ├── erc721preset.test.js
│   ├── intregrate.test.js
│   └── factoryclone.test.js
└── yarn.lock
```

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks: `yarn`

```bash
# cleaning
yarn clean
# compile
yarn compile
yarn coverage
# testing
yarn test:factory
yarn test:erc721
yarn test:rpc
# deployment
yarn deploy:hardhat
yarn deploy:ropsten
yarn deploy:rinkeby
yarn deploy:mainnet
# verify
yarn verify:ropsten
yarn verify:rinkeby
yarn verify:mainnet
# format
yarn eslint
yarn eslint-fix
yarn prettier
yarn prettier-fix
yarn solhint
yarn solhint-fix
```

## Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.template file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```bash
# available on package.json script
# option local, ropsten, rinkeby, mainet
yarn deploy:NETWORK
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```bash
# you need to verify FactoryClone and ERC721Preset
yarn verify:mainet DEPLOYED_CONTRACT_ADDRESS
```

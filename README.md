# Ampersand

## Required Software

- Node JS [Download](https://nodejs.org/en/)
- NVM (you can use it instead NodeJS) [Download](https://github.com/nvm-sh/nvm#installing-and-updating)
- Git [Download](https://git-scm.com/)

If you don't have a yarn. Install yarn by the command below.

```
npm install --global yarn
```

for installing dependencies with yarn using command.

```
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

```shell
# cleaning
yarn clean
# compile
yarn compile
yarn coverage
# testing
yarn test:factory
yarn test:erc721
yarn test-rpc
# deployment
yarn deploy:local
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

# Etherscan verification

To try out Etherscan verification, you first need to deploy a contract to an Ethereum network that's supported by Etherscan, such as Ropsten.

In this project, copy the .env.template file to a file named .env, and then edit it to fill in the details. Enter your Etherscan API key, your Ropsten node URL (eg from Alchemy), and the private key of the account which will send the deployment transaction. With a valid .env file in place, first deploy your contract:

```shell
yarn deploy
```

Then, copy the deployment address and paste it in to replace `DEPLOYED_CONTRACT_ADDRESS` in this command:

```shell
# you need to verify FactoryClone and ERC721Preset
yarn verify:mainet DEPLOYED_CONTRACT_ADDRESS
```

# Documents

- [FactoryClone](./docs/FactoryClone.md)
- [FactoryClone](./docs/IFactoryClone.md)
- [ERC721Preset](./docs/ERC721Preset.md)

# Advanced Sample Hardhat Project

## Required Software

- Node Js [Download](https://nodejs.org/en/)
- Git [Download](https://git-scm.com/)

If you don't have a yarn. Install yarn by the command below.

```
npm install --global yarn
```

And then.

```
yarn install
```

Project directory structure

```shell
.
├── contracts
│   ├── ERC721Preset.sol
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
│   └── deploy-ropsten.js
├── test
│   ├── erc721preset.test.js
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
yarn deploy:mainnet
# verify
yarn verify:ropsten
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
yarn verify DEPLOYED_CONTRACT_ADDRESS CONS_ARGS1 CONS_ARGS2
```

# Documents

- [ERC20](./docs/ERC20)

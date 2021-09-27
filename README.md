# Advanced Sample Hardhat Project

## Required Software

-   Node Js [Download](https://nodejs.org/en/)
-   Git [Download](https://git-scm.com/)

If you don't have a yarn. Install yarn by the command below.
``` 
npm install --global yarn
``` 

And then.
``` 
yarn install
``` 

Project directory structure
``` shell
.
├── contracts
│   ├── TokenERC1155.sol
│   ├── TokenERC20.sol
│   ├── TokenERC721.sol
│   ├── TokenERC777.sol.develop
│   └── TokenFactory.sol
├── coverage.json
├── docs
│   ├── ERC1155.md
│   ├── ERC20.md
│   ├── ERC721.md
│   └── ERC777.md
├── hardhat.config.js
├── LICENSE
├── package.json
├── package-lock.json
├── README.md
├── scripts
│   └── deploy.js
├── test
│   ├── erc1155.test.js
│   ├── erc20_capped.test.js
│   ├── erc20_unCapped.test.js
│   ├── erc721.test.js
│   ├── erc777.test.js
│   ├── factory.test.js
└── yarn.lock

```

This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

The project comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts. It also comes with a variety of other tools, preconfigured to work with the project code.

Try running some of the following tasks: `yarn`

```shell
yarn clean
yarn compile
yarn coverage
yarn test:erc20:capped
yarn test:erc20:uncapped
yarn test:erc721
yarn test:erc1155
yarn test:factory
yarn test-rpc
yarn deploy:factory:local
yarn deploy:factory:erc20:local
yarn deploy:factory:ropsten
yarn deploy-prod
yarn verify:ropsten
yarn REPORT_GAS=true npx hardhat test
yarn npx eslint '**/*.js'
yarn npx eslint '**/*.js' --fix
yarn npx prettier '**/*.{json,sol,md}' --check
yarn npx prettier '**/*.{json,sol,md}' --write
yarn npx solhint 'contracts/**/*.sol'
yarn npx solhint 'contracts/**/*.sol' --fix
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
- [ERC721](./docs/ERC721)  
- [ERC777](./docs/ERC777)  
- [ERC1155](./docs/ERC1155)  
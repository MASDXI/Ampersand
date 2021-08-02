TokenFactory
======

Token Factory contract for creating token with less gas cost deployment, by clone contract functionality/logic  
Factory contract is different from the Proxy contract that points to an already deployed contract.  
In a proxy contract, you need 'address' for reference but the factory contract doesn't need it at all.  

Prerequisite
======
- [nodejs](https://nodejs.org/en/)
- [nvm](https://github.com/nvm-sh/nvm)

Installing and Setup
======
```
$ npm install
```

```
$ npm run compile
```

```
$ npm run test
```

```
$ npm run build
```
FAQ  
======
Q: Contract creation initialization returns data with length of more than 24576 bytes. The deployment will likely fails.  
A: To solving the problem enable `--optimize` and `--optimize-runs 200` in `solcjs` it can produce smaller and more gas-efficient EVM bytecode,  
If developing on REMIX IDE enable solidity compiler and enable optimization before deploying it.  

Q: Fail not Found or Fail import callback not supported. (VSCode)  
A: change `import @openzeppelin/...` to `import ../node_modules/@openzeppelin/...`

Q: How to deploy is project.  
A: You can use you fav tools Hardhat, Truffle and more.  

Q: Why this project don't come with Hardhat or Truffle tool.  
A: For flexibility development in any blockchain that supported EVM bytecode.  

Todo
======
- [ ] Support multiple types of token 
  - [X] support ERC20
  - [X] support ERC721
  - [ ] support ERC777 
  - [X] support ERC1155
- [ ] Additonal Feature  
  - [ ] Zero-Knowledge Proof (ZKP) private txs  
  - [ ] Mint  
  - [ ] Burn  
  - [ ] Freeze  
  - [ ] Unfreeze  
  - [ ] Transfer Ownership  
  - [ ] Upgrade  

## disclaimer 
- this smart contract not implementing Ownable yet.  
- this smart contract provide code structure your can modified it, if needed.

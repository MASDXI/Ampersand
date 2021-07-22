# TokenFactory
Token Factory contract for creating token with less gas cost deployment, by clone contract functionality/logic  
Factory contract is different from the Proxy contract that points to an already deployed contract.  
In a proxy contract, you need 'address' for reference but the factory contract doesn't need it at all.  
### Prerequisite
- [nodejs](https://nodejs.org/en/)
- [nvm](https://github.com/nvm-sh/nvm)

### Installing and Setup
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
### FAQ 

Q: Contract creation initialization returns data with length of more than 24576 bytes. The deployment will likely fails.  
A: To solving the problem enable `--optimize` and `--optimize-runs n` in `solcjs` it can produce smaller and more gas-efficient EVM bytecode.
If developing on REMIX IDE Enable optimization

### Todo

- [ ] Support multiple types of token 
  - [X] support ERC20
  - [X] support ERC721
  - [ ] support ERC777
  - [ ] support ERC1155
- [ ] Additonal Feature  
  - [ ] Zero-Knowledge Proof (ZKP) private txs  
  - [ ] Mint  
  - [ ] Burn  
  - [ ] Freeze  
  - [ ] Unfreeze  
  - [ ] Transfer Ownership  
  - [ ] Upgrade  

### disclaimer 
- this smart contract not implementing Ownable yet.  
- ...

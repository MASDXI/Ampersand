# TokenFactory
Token Factory contract for create token with low gas cost deployment, by clone contract functionality/logic  
Token to prevent  
```
 Contract creation initialization returns data with length of more than 24576 bytes. The deployment will likely fails.
```
to solving the problem enable `--optimize` and `--optimize-runs n` in `solcjs` it can produce smaller and more gas-efficient EVM bytecode.
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

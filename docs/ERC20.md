# ERC20 Token


`constructor`
``` js
     constructor(
        string _name, 
        string _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        TOKEN_TYPE _tokenType
    )
```

`TOKEN_TYPE`
``` js
    enum TOKEN_TYPE {CAPPED,UNCAPPED}
    // 0 = CAPPED for disable mint/burn function
    // 1 = UNCAPPED for enbale mint/burn function
```

### Data-type 

| VARIALBLE          | TYPE        | EXAMPLE       |
| ------------------ | ----------- | ------------- |
| __name_            | string      | "Basic Coin"  |
| __symbol_          | string      | "BSC"         |
| __decimals_        | uint8       | 18            |
| __initialSupply_   | uint8       | 10000000      |
| __tokenType_       | enum        | 0             |

## ERC20 API

`name`  
``` js
    name() -> string
    // method: callcontract  
```
`symbol`  
``` js
    symbol() -> string
    // method: callcontract  
```

`decimals`  
``` js
    decimals() -> uint8
    // method: callcontract  
```

`totalSupply`  
``` js
    totalSupply() -> uint256
    // method: callcontract  
```

`balanceOf`  
``` js
    balanceOf(address _account) -> uint256
    // method: callcontract  
```

`transfer`
``` js
    transfer(address _account, uint256 _amount) -> bool
    // method: sendtocontract  
```

# ERC20 Token


`constructor`
``` js
     constructor(string _name, 
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

// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// NodeJS
// import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";

// REMIX IDE
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract _token is ERC20 {
    
    uint8 private currentDecimals;
    
    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _initialSupply totalSupply
     * @dev to create token require following parameters
    */
    constructor(
        string memory _name, 
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) {
        currentDecimals = _decimals;
        // mint token to the address of the account that sent the transaction.
        _mint(tx.origin, _initialSupply * (10**uint256(_decimals)));
    }

    function decimals() public view virtual override returns (uint8) {
        return currentDecimals;
    }

}
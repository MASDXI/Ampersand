// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Token.sol";

contract Factory {
    
    event TokenCreated(address indexed tokenAddress);
    address[] private tokenAddress;
    
    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _totalSupply totalSupply
     * @dev to create token require following parameters
     * @return address after token created successful
    */
    function createToken(
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals,
        uint256 _totalSupply
    ) public returns (address) {
        _token Token = new _token(_name, _symbol, _decimals, _totalSupply);
        emit TokenCreated(address(Token));
        tokenAddress.push(address(Token));
        return address(Token);
    }
    
    // helper function for retreive address easier
    function getTokenAddress(uint256 _index) public view returns (address){
        return tokenAddress[_index];
    }
    
    function getLength() public view returns (uint256){
        return tokenAddress.length;
    }
} 
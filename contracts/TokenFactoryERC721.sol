// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC721.sol";

contract TokenFactoryERC721 {
    
    event TokenCreated(address indexed tokenAddress);

    address[] private erc721Address;

    /**
     * @param _name name
     * @param _symbol symbol
     * @param _baseTokenURI baseTokenURI
     * @param _price price
     * @param _maxSupply maxSupply
     * @param _maxSalePerOrder maxSalePerOrder
     * @dev to create token with ERC721 standard require following parameters
     * @return address after token created successful
    */
    function createERC721(
        string memory _name, 
        string memory _symbol, 
        string memory _baseTokenURI, 
        uint256 _price, 
        uint256 _maxSupply,
        uint256 _maxSalePerOrder
    ) public returns (address, uint256) {
        _ERC721 token = new _ERC721(
            _name, _symbol, 
            _baseTokenURI, 
            _price, 
            _maxSupply, 
            _maxSalePerOrder);
        erc721Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc721Address.length-1);
    }
}

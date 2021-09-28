// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC721.sol";

contract TokenFactoryERC721 {
    
    //ERROR CODE
    //001: Sale paused
    //002: ETH not enough

    event TokenCreated(address indexed tokenAddress);

    address[] private erc721Address;

    uint256 private price = 1 ether;
    bool private paused = true;

    function createERC721(
        string memory _name, 
        string memory _symbol, 
        string memory _baseTokenURI, 
        uint256 _price, 
        uint256 _maxSupply,
        uint256 _maxSalePerOrder,
        address[] memory _teamAddress
    ) public payable returns (address, uint256) {
        require(!paused, "001");
        require(msg.value >= price, "002");
        _ERC721 token = new _ERC721(
            _name, _symbol, 
            _baseTokenURI, 
            _price, 
            _maxSupply, 
            _maxSalePerOrder,
            _teamAddress);
        erc721Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc721Address.length-1);
    }

    // TODO return address customer contract.
    // TODO withdraw function.
}

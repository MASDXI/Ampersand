// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./TokenERC721.sol";

contract TokenFactoryERC721 is Ownable {
    
    //ERROR CODE
    //001: Sale paused
    //002: ETH not enough

    event TokenCreated(address indexed tokenAddress);

    address[] private erc721Address;

    address private feesAddress = 0x652bdd352F620876A1C98d8d59DDf2Fa5cf08a36;
    uint256 private fees = 10;

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

    // function getTokenAddress() public view virtual returns (address[] memory) {
    //     return erc721Address;
    // }

    function getFeesAddress() public view virtual returns (address) {
        return feesAddress;
    }

    function setFeesAddress(address _feesAddress) public onlyOwner {
        feesAddress = _feesAddress;
    }

    function getFees() public view virtual returns (uint256) {
        return fees;
    }

    function setFees(uint256 _fees) public onlyOwner {
        fees = _fees;
    }
    
    function getPrice() public view virtual returns (uint256) {
        return price;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function getPaused() public view virtual returns (bool) {
        return paused;
    }

    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function withdrawAll() public payable onlyOwner {
        payable(feesAddress).transfer(address(this).balance);
    }
}

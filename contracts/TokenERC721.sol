// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./TokenFactoryERC721.sol";

contract _ERC721 is ERC721Enumerable, Ownable {
    
    //ERROR CODE
    //001: Sale ended
    //002: Exceeds maximum supply
    //003: Sale paused
    //004: Over maximum can buy
    //005: ETH not enough
    //006: 0.1 ETH is a minimum withdraw

    // factory addresses
    address private factoryAddress = msg.sender;

    // team addresses
    address[] private teamAddress;

    string private baseTokenURI;
    uint256 private price;
    uint256 private maxSupply;
    uint256 private maxSalePerOrder;

    bool private paused = true;

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _baseTokenURI,
        uint256 _price,
        uint256 _maxSupply,
        uint256 _maxSalePerOrder,
        address[] memory _teamAddress
    ) ERC721(_name, _symbol) {
        baseTokenURI = _baseTokenURI;
        price = _price;
        maxSupply = _maxSupply;
        maxSalePerOrder = _maxSalePerOrder;
        teamAddress = _teamAddress;
        transferOwnership(tx.origin);
    }

    function getTokenAddress() public view virtual returns (address[] memory) {
        return teamAddress;
    }

    function setPrice(address[] memory _teamAddress) public onlyOwner {
        teamAddress = _teamAddress;
    }

    function getPrice() public view virtual returns (uint256) {
        return price;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function getMaxSupply() public view virtual returns (uint256) {
        return maxSupply;
    }

    function setMaxSupply(uint256 _maxSupply) public onlyOwner {
        maxSupply = _maxSupply;
    }

    function getMaxSalePerOrder() public view virtual returns (uint256) {
        return maxSalePerOrder;
    }

    function setMaxSalePerOrder(uint256 _maxSalePerOrder) public onlyOwner {
        maxSalePerOrder = _maxSalePerOrder;
    }

    function getBaseTokenURI() public view virtual returns (string memory) {
        return baseTokenURI;
    }

    function setBaseTokenURI(string memory _baseTokenURI) public onlyOwner {
        baseTokenURI = _baseTokenURI;
    }

    function getPaused() public view virtual returns (bool) {
        return paused;
    }

    function setPaused(bool _paused) public onlyOwner {
        paused = _paused;
    }

    function mintTo(address _address) public onlyOwner {
        uint256 supply = totalSupply();
        require(supply < maxSupply, "001");

        _mint(_address, supply + 1);
    }

    function mintFactory(address _address, uint256 num) public onlyOwner {
        uint256 supply = totalSupply();
        require(supply + num <= maxSupply, "002");

        for (uint256 i = 1; i <= num; i++) {
            _mint(_address, supply + i);
        }
    }

    function buy(uint256 num) public payable {
        uint256 supply = totalSupply();
        require(supply + num <= maxSupply, "002");
        require(!paused, "003");
        require(num <= maxSalePerOrder, "004");
        require(msg.value >= price * num, "005");

        for (uint256 i = 1; i <= num; i++) {
            _mint(msg.sender, supply + i);
        }
    }

    function giftTo(uint256 num, address _address) public payable {
        uint256 supply = totalSupply();
        require(supply + num <= maxSupply, "002");
        require(!paused, "003");
        require(num <= maxSalePerOrder, "004");
        require(msg.value >= price * num, "005");

        for (uint256 i = 1; i <= num; i++) {
            _mint(_address, supply + i);
        }
    }

    function withdrawAll() public payable onlyOwner {
        require(address(this).balance > 0.1 ether, "006");

        TokenFactoryERC721 factory = TokenFactoryERC721(factoryAddress);

        uint256 each = (address(this).balance * ((100 - factory.getFees()) / 100) / teamAddress.length);

        for (uint256 i = 0; i < teamAddress.length; i++) {
            payable(teamAddress[i]).transfer(each);
        }
        
        payable(factory.getFeesAddress()).transfer(address(this).balance);
    }

    function _baseURI() internal view override virtual returns (string memory) {
        return baseTokenURI;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./IFactoryClone.sol";
import "./ERC721Preset.sol";

//  .d8888b.
// d88P  "88b
// Y88b. d88P
//  "Y8888P"
// .d88P88K.d88P
// 888"  Y888P"
// Y88b .d8888b
//  "Y8888P" Y88b
// ａｍｐｅｒｓａｎｄ

contract FactoryClone is Ownable, Pausable, IFactoryClone {
    /**
     * ERROR code handle
     *
     *
     *
     *
     *
     */

    address immutable _tokenImplementation;
    address private _feesAddres;
    uint256 private _fees;
    uint256 private _createPrice;

    struct TokenBag {
        address[] tokenAddress;
    }

    mapping(address => TokenBag) tokenList;

    constructor() {
        _tokenImplementation = address(new ERC721Preset());
        _feesAddres = _msgSender();
        _fees = 0 ether;
        // _fees = 0.001 ether // uncommment this line when `production`
        // _feeAddress = 0x<YOUR_ADDRESS>; // uncommment this line when `production`
        // _pause(); // uncommment this line when `production`
    }

    function createToken(ERC721Preset.tokenInfo calldata token)
        external
        payable
        whenNotPaused
        returns (address)
    {
        require(msg.value >= createPrice(), "002");
        address clone = Clones.clone(_tokenImplementation);
        ERC721Preset(clone).initialize(token, _msgSender());
        emit TokenCreated(
            token._name,
            token._symbol,
            token._baseTokenURI,
            address(clone)
        );
        tokenList[_msgSender()].tokenAddress.push(address(clone));
        return address(clone);
    }

    function getTokenAddress(address _address)
        public
        view
        virtual
        returns (address[] memory)
    {
        return tokenList[_address].tokenAddress;
    }

    function pause() public virtual onlyOwner {
        _pause();
    }

    function unpause() public virtual onlyOwner {
        _unpause();
    }

    function withdrawAll() public payable onlyOwner {
        require(address(this).balance > 0, "0x000002");
        payable(msg.sender).transfer(address(this).balance);
    }

    function fees() public view virtual override returns (uint256) {
        return _fees;
    }

    function setFees(uint256 price) public onlyOwner {
        _fees = price;
        emit FeesUpdated(price);
    }

    function feesAddress() public view virtual override returns (address) {
        return _feesAddres;
    }

    function setFeesAddress(address to) public onlyOwner {
        _feesAddres = to;
        emit FeesAddressChanged(to);
    }

    function createPrice() public view returns (uint256) {
        return _createPrice;
    }

    function setCreatePrice(uint256 price) public onlyOwner {
        _createPrice = price;
        emit createPriceUpdated(price);
    }
}

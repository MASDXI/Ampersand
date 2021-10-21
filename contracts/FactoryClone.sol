// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./IFactoryClone.sol";
import "./ERC20Preset.sol";

//  .d8888b.
// d88P  "88b
// Y88b. d88P
//  "Y8888P"
// .d88P88K.d8FT
// 888"  Y888P"
// Y88b .d8888b
//  "Y8888P" Y88b
// ａｍｐｅｒｓａｎｄ

contract FactoryClone is Ownable, Pausable, IFactoryClone {
    /**
     * ERROR code handle
     * CRC32 encode
     */
    mapping(address => TokenBag) tokenList;
    address immutable _tokenImplementation;

    uint256 private _createPrice;

    struct TokenBag {
        address[] tokenAddress;
    }

    constructor() {
        _createPrice = 0;
        _tokenImplementation = address(new ERC20Preset());
        // factory._createPrice = 10 // uncommment this line when `production`
        // _pause(); // uncommment this line when `production`
    }

    function createToken(ERC20Preset.tokenInfo calldata token)
        external
        payable
        whenNotPaused
        returns (address)
    {
        require(msg.value >= createPrice(), "736d4bef");
        address clone = Clones.clone(_tokenImplementation);
        ERC20Preset(clone).initialize(token, _msgSender());
        emit TokenCreated(
            token._decimals,
            token._totalSupply,
            token._name,
            token._symbol,
            address(clone)
        );
        tokenList[_msgSender()].tokenAddress.push(address(clone));
        return address(clone);
    }
    
    function getImplemetation() public view returns (address) {
        return _tokenImplementation;
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
        require(address(this).balance > 0, "17854c4f");
        payable(_msgSender()).transfer(address(this).balance);
    }

    function createPrice() public view returns (uint256) {
        return _createPrice;
    }

    function setCreatePrice(uint256 price) public onlyOwner {
        _createPrice = price;
        emit createPriceUpdated(price);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
//import "@openzeppelin/contracts-upgradeable/token/ERC721/presets/ERC721PresetMinterPauserAutoIdUpgradeable.sol";
import "./ERC721Preset.sol";
// import "./IFactoryClone.sol";

contract FactoryClone is Ownable, Pausable {

    address immutable tokenImplementation;

    event TokenCreated(string, string, string, address indexed);

    struct TokenBag {
        address[] tokenAddress;
    }

    mapping(address => TokenBag) tokenList;

    constructor() public {
        tokenImplementation = address(new ERC721Preset());
    }

    function createToken(
        string calldata name,
        string calldata symbol,
        string calldata baseTokenURI
    ) external whenNotPaused payable returns (address) {
        address clone = Clones.clone(tokenImplementation);
        ERC721Preset(clone).initialize(
            name, 
            symbol,
            baseTokenURI,
            msg.sender);
        emit TokenCreated(name, symbol, baseTokenURI, clone);
        tokenList[msg.sender].tokenAddress.push(clone);
        return clone;
    }

    function getTokenAddress(address _address) public view virtual returns (address[] memory) {
        return tokenList[_address].tokenAddress;
    }

    function setPaused(uint8 _state) public onlyOwner {
        if ( _state == 1) {
            _pause();
        } else {
            _unpause();
        }
    }

    function withdrawAll() public payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

}
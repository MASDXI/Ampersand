// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./ERC721Preset.sol";

contract FactoryClone is Ownable, Pausable {

    // ERROR code handle
    // `0x0001` state already set
    // `0x0002` contract.balance > (0)

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
        tokenList[msg.sender].tokenAddress.push(address(clone));
        return address(clone);
    }

    function getTokenAddress(address _address) public view virtual returns (address[] memory) {
        return tokenList[_address].tokenAddress;
    }

    function setPaused(bool _state) public onlyOwner {
        require(paused() != _state, "0x000001");
        if ( _state == true) {
            _pause();
        } else {
            _unpause();
        }
    }

    function withdrawAll() public payable onlyOwner {
        require(address(this).balance) > 0, "0x000002")
        payable(msg.sender).transfer(address(this).balance);
    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/presets/ERC721PresetMinterPauserAutoIdUpgradeable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";

contract FactoryClone {
    address immutable tokenImplementation;

    constructor() public {
        tokenImplementation = address(new ERC721PresetMinterPauserAutoIdUpgradeable());
    }

    function createToken(
        string calldata name,
        string calldata symbol,
        string calldata baseTokenURI
    ) external payable returns (address) {
        address clone = Clones.clone(tokenImplementation);
        ERC721PresetMinterPauserAutoIdUpgradeable(clone).initialize(
            name, 
            symbol,
            baseTokenURI);
        return clone;
    }
}
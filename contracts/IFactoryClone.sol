// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFactoryClone {
    event TokenCreated(
        string name,
        string symbol,
        uint8 decimals,
        uint256 totalSupply,
        address indexed _contract
    );
    event createPriceUpdated(uint256 amount);
}

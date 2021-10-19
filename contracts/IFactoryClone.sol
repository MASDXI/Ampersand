// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFactoryClone {
    event TokenCreated(
        uint8 decimals,
        uint256 totalSupply,
        string name,
        string symbol,
        address indexed _contract
    );
    event createPriceUpdated(uint256 amount);
}
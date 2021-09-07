// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract _ERC1155 is ERC1155, Ownable {
    
    struct Token {
        uint256 id;
        uint amount;
        // bytes data; if needed
    }

    constructor(
        Token[] memory _tokens,
        string memory _uri
    ) ERC1155(_uri) {
        transferOwnership(tx.origin);
        for (uint i = 0; i < _tokens.length; i++) {
           _mint(tx.origin, _tokens[i].id, _tokens[i].amount, "");
        }
    }

}

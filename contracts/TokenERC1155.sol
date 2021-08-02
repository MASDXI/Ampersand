// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// import callback node_modules
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// import callback url
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract _ERC1155 is ERC1155 {
    
    struct token {
        uint256 id;
        uint amount;
        // bytes data; if needed
    }

    constructor(
        token[] memory _tokens,
        string _uri
    ) ERC1155(_uri) {
        for (uint i = 0; i < token.length; i++) {
           _mint(tx.origin, token[i].id, token[i].amount, "");
        }
    }

}

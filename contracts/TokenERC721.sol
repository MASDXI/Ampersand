// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// import callback node_modules
import "@openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/utils/Counters.sol";

// import callback url
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Counters.sol";

contract _ERC721 is ERC721URIStorage  {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor(
        string memory _name,
        string memory _symbol)
        ERC721(_name, _symbol) {
    }

    function mint(address _address, string memory _tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _safeMint(_address, newItemId);
        _setTokenURI(newTokenId, _tokenURI);
        return newTokenId;
    }

}
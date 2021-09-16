// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract _ERC721 is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    enum TOKEN_TYPE {TRANSFERABLE,UNTRANFERABLE}
    bool private royalty
    TOKEN_TYPE public tokenType;

    constructor(
        string memory _name,
        string memory _symbol,
        bool _royalty
        )
        ERC721(_name, _symbol) {
        transferOwnership(tx.origin);
    }

    modifier transferable {
      require(tokenType == _ERC721.TOKEN_TYPE.TRANSFERABLE,"support only transferable token");
      _;
    }

    function mint(address _address, string memory _tokenURI) public returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();
        _safeMint(_address, newTokenId);
        _setTokenURI(newTokenId, _tokenURI);
        return newTokenId;
    }

    function Transfer(address _address, address _to, uint256 _tokenId) public transferable return (bool) {
        _transfer(_address,_to,_tokenId);
        return true
    }

    // This function with implementing when needed usually on marketplace platform
    // function _beforeTokenTransfer(address from,address to,uint256 tokenId) internal virtual override (ERC721, ERC721Pausable) {
    //     super._beforeTokenTransfer(from, to, tokenId);
    //     // do stuff or something before every transfer
    //     // e.g. royalty fees
    // }

}
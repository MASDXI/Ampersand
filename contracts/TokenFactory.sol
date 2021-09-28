// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC20.sol";
import "./TokenERC721.sol";
//import "./TokenERC777.sol";
import "./TokenERC1155.sol";

contract TokenFactory {
    
    event TokenCreated(address indexed tokenAddress);

    address[] private erc20Address;
    address[] private erc721Address;
    address[] private erc777Address;
    address[] private erc1155Address;
    // uint8 constant ERC_20 = 0;
    // uint8 constant ERC_721 = 1;
    // uint8 constant ERC_777 = 2;
    // uint8 constant ERC_1155 = 3;

    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _totalSupply totalSupply
     * @param _tokenType type of token
     * @dev to create token with ERC20 standard require following parameters
     * @return address after token created successful
    */
    function createERC20(
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals,
        uint256 _totalSupply,
        _ERC20.TOKEN_TYPE _tokenType
    ) public returns (address, uint256) {
        // TODO: adding `_privacyType` type enum for intregrating privacy feature.
        _ERC20 token = new _ERC20(_name, 
            _symbol, 
            _decimals, 
            _totalSupply, 
            _tokenType);
        erc20Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc20Address.length-1);
    }

/**
     * @param _name name
     * @param _symbol symbol
     * @param _baseTokenURI base token URI
     * @param _price price
     * @param _maxSupply max supply
     * @param _maxSalePerOrder max sale per order
     * @param _teamAddress team address
     * @dev to create token with ERC721 standard require following parameters
     * @return address after token created successful
    */
    function createERC721(
        string memory _name, 
        string memory _symbol, 
        string memory _baseTokenURI, 
        uint256 _price, 
        uint256 _maxSupply,
        uint256 _maxSalePerOrder,
        address[] memory _teamAddress
    ) public payable returns (address, uint256) {
        _ERC721 token = new _ERC721(
            _name, _symbol, 
            _baseTokenURI, 
            _price, 
            _maxSupply, 
            _maxSalePerOrder,
            _teamAddress);
        erc721Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc721Address.length-1);
    }

    /** 
     * @dev to create token with ERC777 standardrequire following parameters
     * @return address after token created successful
    */
    // function createERC777() public returns (address, uint256) {
    //     // TODO: define params
    //     _ERC777 token = new _ERC777();
    //     erc777Address.push(address(token));
    //     emit TokenCreated(address(token));
    //     return (address(token),erc777Address.length-1);
    // }

    /** 
     * @param _tokens tuple(uint256,uint256)[]
     * @param _uri uri path
     * @dev to create token with ERC1155 standard require following parameters
     * @return address after token created successful
    */
    function createERC1155(_ERC1155.Token[] memory _tokens, string memory _uri) public returns (address, uint256) {
        // TODO: define params
        _ERC1155 token = new _ERC1155(_tokens,_uri);
        erc1155Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc1155Address.length-1);
    }


    // TODO call function for retrieve `address` by `index`
    // function getTokenAddress(uint256 _index, uint256 _tokenType) public view returns (address){
    //     if ( _tokenType == ERC_20) {
    //         return erc20Address[_index];
    //     }
    //     if ( _tokenType == ERC_721) {
    //         return erc20Address[_index];
    //     }
    //     if ( _tokenType == ERC_777) {
    //         return erc20Address[_index];
    //     }
    //     if ( _tokenType == ERC_1155) {
    //         return erc20Address[_index];
    //     }
    // }
    
    // TODO call function for retrieve `array.length` by `tokentype`
    // function getTokenLength(uint256 _tokenType) public view returns (uint256){
    //     if ( _tokenType == ERC_20) {
    //         return erc20Address.length;
    //     }
    //     if ( _tokenType == ERC_721) {
    //         return erc721Address.length;
    //     }
    //     if ( _tokenType == ERC_777) {
    //         return erc777Address.length;
    //     }
    //     if ( _tokenType == ERC_1155) {
    //         return erc1155Address.length;
    //     }
    // }
}

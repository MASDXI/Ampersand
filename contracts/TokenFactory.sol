// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC20.sol";
import "./TokenERC721.sol";
// import "./TokenERC777.sol";
// import "./TokenERC1155.sol";

contract TokenFactory {
    
    event TokenCreated(address indexed tokenAddress);

    address[] private erc20Address;
    address[] private erc721Address;
    address[] private erc777Address;
    address[] private erc1155Address;
    uint8 constant ERC_20 = 0;
    uint8 constant ERC_721 = 1;
    uint8 constant ERC_777 = 2;
    uint8 constant ERC_1155 = 3;

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
        _token.TOKEN_TYPE _tokenType
    ) public returns (address, uint256) {
        // TODO: adding `_privacyType` type enum for intregrating privacy feature.
        _token token = new _token(_name, 
            _symbol, 
            _decimals, 
            _totalSupply, 
            _tokenType);
        erc20Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc20Address.length);
    }

    /** 
     * @dev to create token with ERC721 standard require following parameters
     * @return address after token created successful
    */
    function createERC721(string memory _name, string memory _symbol) public returns (address, uint256) {
        // TODO: define params
        _token token = new _token(_name, _symbol);
        erc777Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc777Address.length-1);
    }

    /** 
     * @dev to create token with ERC777 standardrequire following parameters
     * @return address after token created successful
    */
    function createERC777() public returns (address, uint256) {
        // TODO: define params
        _token token = new _token();
        erc777Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc777Address.length-1);
    }

    /** 
     * @dev to create token with ERC1155 standard require following parameters
     * @return address after token created successful
    */
    function createERC1155() public returns (address, uint256) {
        // TODO: define params
        _token token = new _token();
        erc1155Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc1155Address.length-1);
    }

    
    // call function for retrieve `address` by `index`

    function getTokenAddress(uint256 _index, uint256 _tokenType) public view returns (address){
        if ( _tokenType == 0) {
            return erc20Address[_index];
        }

        if ( _tokenType == 1) {
            return erc20Address[_index];
        }

        if ( _tokenType == 2) {
            return erc20Address[_index];
        }

        if ( _tokenType == 3) {
            return erc20Address[_index];
        }
    }
    
    // call function for retrieve `array.length` by `tokentype`

    function getTokenLength(uint256 _tokenType) public view returns (uint256){
        if ( _tokenType == 0) {
            return erc20Address.length;
        }

        if ( _tokenType == 1) {
            return erc721Address.length;
        }

        if ( _tokenType == 2) {
            return erc777Address.length;
        }

        if ( _tokenType == 3) {
            return erc1155Address.length;
        }
    }
}

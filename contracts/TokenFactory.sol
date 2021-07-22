// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC20.sol";
import "./TokenERC721.sol";
import "./TokenERC777.sol";
import "./TokenERC1155.sol";

contract TokenFactory {
    
    event TokenCreated(address indexed tokenAddress);
    address[] private erc20Address;
    address[] private erc721Address;
    address[] private erc777Address;
    address[] private erc1155Address;

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
        erc20address.push(address(token));
        emit TokenCreated(address(token));
        return (address(Token),erc20Address.length);
    }

    /** 
     * @dev to create token with ERC721 standard require following parameters
     * @return address after token created successful
    */
    function createERC721() public returns (address, uint256) {
        _token token = new _token();
        erc777address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc777Address.length);
    }

    /** 
     * @dev to create token with ERC777 standardrequire following parameters
     * @return address after token created successful
    */
    function createERC777() public returns (address, uint256) {
        _token token = new _token();
        erc777address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc777Address.length);
    }

    /** 
     * @dev to create token with ERC1155 standard require following parameters
     * @return address after token created successful
    */
    function createERC1155() public returns (address, uint256) {
        _token token = new _token();
        erc1155address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token),erc1155Address.length);
    }

    
    // call function for retrieve `address` by `index`

    // function getTokenAddress(uint256 _index) public view returns (address){
    //     return tokenAddress[_index];
    // }
    
    // call function for retrieve `array.length`

    // function getLength() public view returns (uint256){
    //     return tokenAddress.length;
    // }
}

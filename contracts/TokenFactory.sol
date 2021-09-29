// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./TokenERC20.sol";

contract TokenFactory {
    event TokenCreated(address indexed tokenAddress);

    address[] private erc20Address;

    // uint8 constant ERC_20 = 0;

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
        _ERC20 token = new _ERC20(
            _name,
            _symbol,
            _decimals,
            _totalSupply,
            _tokenType
        );
        erc20Address.push(address(token));
        emit TokenCreated(address(token));
        return (address(token), erc20Address.length - 1);
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

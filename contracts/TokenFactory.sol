// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "./Token.sol";

contract Factory {
    
    event TokenCreated(address indexed tokenAddress);
    address[] private erc20address;
    address[] private erc721address;
    address[] private erc777address;
    address[] private erc1155address;

    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _totalSupply totalSupply
     * @param _tokenType type of token
     * @dev to create token require following parameters
     * @return address after token created successful
    */
    function createERC20(
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals,
        uint256 _totalSupply,
        _token.TOKEN_TYPE _tokenType
    ) public returns (address, uint256) {
        _token Token = new _token(_name, 
            _symbol, 
            _decimals, 
            _totalSupply, 
            _tokenType);
        erc20address.push(address(Token));
        emit TokenCreated(address(Token));
        return (address(Token),erc20address.length);
    }

    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _baseURI baseURI
     * @dev to create token require following parameters
     * @return address after token created successful
    */
    function createERC721(
        string memory _name, 
        string memory _symbol, 
        string memory _baseURI
    ) public returns (address, uint256) {
        _token Token = new _token(_name, _symbol, _baseURI);
        erc721address.push(address(Token));
        emit TokenCreated(address(Token));
        return (address(Token),erc721address.length);
    }

    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _totalSupply totalSupply
     * @param _defaultOperators defaultOperators
     * @param _tokenType type of token
     * @dev to create token require following parameters
     * @return address after token created successful
    */
    function createERC777(
        string memory _name, 
        string memory _symbol, 
        uint8 _decimals,
        uint256 _totalSupply,
        address [] memory _defaultOperators,
        _token.TOKEN_TYPE _tokenType
    ) public returns (address, uint256) {
        _token Token = new _token(_name, 
            _symbol, 
            _decimals, 
            _totalSupply, 
            _defaultOperators, 
            _tokenType);
        erc777address.push(address(Token));
        emit TokenCreated(address(Token));
        return (address(Token),erc777address.length);
    }

    /** 
     * @param _name name
     * @param _symbol symbol
     * @param _decimals decimals
     * @param _totalSupply totalSupply
     * @param _defaultOperators defaultOperators
     * @param _tokenType type of token
     * @dev to create token require following parameters
     * @return address after token created successful
    */
    function createERC1155(
        string memory _uri, 
        uint256 [] _totalSupply
    ) public returns (address, uint256) {
        _token Token = new _token(_uri, _totalSupply);
        erc1155address.push(address(Token));
        emit TokenCreated(address(Token));
        return (address(Token),erc1155address.length);
    }

    
    // helper function for retreive address easier
    // function getTokenAddress(uint256 _index) public view returns (address){
    //     return tokenAddress[_index];
    // }
    
    // function getLength() public view returns (uint256){
    //     return tokenAddress.length;
    // }
}

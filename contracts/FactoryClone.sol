// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "./IFactoryClone.sol";
import "./ERC721Preset.sol";

contract FactoryClone is Ownable, Pausable {
    /**
     * ERROR code handle
     * `0x0001` state already set
     * `0x0002` contract.balance > (0)
     *
     *
     *
     *
     *
     */

    // task
    // TODO custom ERC721 feature
    // TODO adjust optimizer low runs
    // TODO unit-testing factory
    // TODO unit-testing erc721
    // TODO code coverage

    address immutable tokenImplementation;
    // address can be change
    address private immutable _feeAddress = 0x256656266a47E7b21Bba1D8d46af5F8804D775E1;
    uint256 private _fees;

    event TokenCreated(address indexed clone);

    struct TokenBag {
        address[] tokenAddress;
    }

    mapping(address => TokenBag) tokenList;

    constructor() {
        tokenImplementation = address(new ERC721Preset());
        // _pause(); uncommment this line when `production`
    }

    function createToken(ERC721Preset.tokenInfo calldata token) external payable whenNotPaused returns (address) {
        address clone = Clones.clone(tokenImplementation);
        ERC721Preset(clone).initialize(
            token,
            _msgSender()
        );
        emit TokenCreated(address(clone));
        tokenList[_msgSender()].tokenAddress.push(address(clone));
        return address(clone);
    }

    function getTokenAddress(address _address)
        public
        view
        virtual
        returns (address[] memory)
    {
        return tokenList[_address].tokenAddress;
    }

    function setPaused(bool _state) public onlyOwner {
        require(paused() != _state, "0x000001");
        if (_state == true) {
            _pause();
        } else {
            _unpause();
        }
    }

    function withdrawAll() public payable onlyOwner {
        require(address(this).balance > 0, "0x000002");
        payable(msg.sender).transfer(address(this).balance);
    }

    function fees() public view virtual returns (uint) {
        return _fees;
    }

    function feesAddress() public view virtual returns (address) {
        return _feeAddress;
    }
}

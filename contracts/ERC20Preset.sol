// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC721PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "./IFactoryClone.sol";

//  .d8888b.
// d88P  "88b
// Y88b. d88P
//  "Y8888P"
// .d88P88K.dNFT
// 888"  Y888P"
// Y88b .d8888b
//  "Y8888P" Y88b
// ａｍｐｅｒｓａｎｄ

contract ERC721Preset is
    Initializable,
    ContextUpgradeable,
    AccessControlEnumerableUpgradeable,
    ERC721Upgradeable,
    ERC721EnumerableUpgradeable,
    ERC721PausableUpgradeable,
{
    /**
     * ERROR code handle
     * CRC32 encode
     * a4fb704b ERC721Preset: require DEFAULT_ADMIN_ROLE role
     * 24113153 ERC721Preset: require MINTER_ROLE role
     * 500c80ca ERC721Preset: require PAUSER_ROLE role
     * 9c7b6c43 ERC721Preset: exceeds maximum supply
     * a4006875 ERC721Preset: exceeds maximum purchase per tx
     * 3e2087fb ERC721Preset: price not correct
     * afa07ab7 ERC721Preset: require eth more than 10000 gwei
     */

    function initialize(tokenInfo memory input, address owner)
        public
        virtual
        initializer
    {
        __ERC721PresetMinterPauserAutoId_init(input, owner);
    }

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    struct tokenInfo {
        uint8 _decimals;
        uint256 _totalSupply;
        string _name;
        string _symbol;
    }

    address private _factoryAddress;
    tokenInfo private token;

    function __ERC721PresetMinterPauserAutoId_init(
        tokenInfo memory input,
        address owner
    ) internal initializer {
        __Context_init_unchained();
        __ERC165_init_unchained();
        __AccessControl_init_unchained();
        __AccessControlEnumerable_init_unchained();
        __ReentrancyGuard_init_unchained();
        __ERC721_init_unchained(input._name, input._symbol);
        __ERC721Enumerable_init_unchained();
        __Pausable_init_unchained();
        __ERC721Pausable_init_unchained();
        __ERC721PresetMinterPauserAutoId_init_unchained(input, owner);
    }

    function __ERC721PresetMinterPauserAutoId_init_unchained(
        tokenInfo memory input,
        address owner
    ) internal initializer {
        token = input;
        _factoryAddress = _msgSender();
        _setupRole(DEFAULT_ADMIN_ROLE, owner);
        _setupRole(MINTER_ROLE, owner);
        _setupRole(PAUSER_ROLE, owner);
        // _pause(); // uncommment this line when `production`
    }


    function decimals() public view virtual override returns (uint8) {
        return token._decimals;
    }

    function maxPurchase() public view returns (uint256) {
        return token._maxPurchase;
    }


    function withdraw() public payable {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "a4fb704b");
        // require(address(this).balance > 10000 gwei, "afa07ab7"); // uncomment this line when `production`
        IFactoryClone factory = IFactoryClone(_factoryAddress);
        uint256 each = ((address(this).balance *
            ((100 - factory.fees()) / 100)) / token._collaborator.length);

        for (uint256 i = 0; i < token._collaborator.length; i++) {
            payable(token._collaborator[i]).transfer(each);
        }

        payable(factory.feesAddress()).transfer(address(this).balance);
    }



    function mint(address to) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "24113153");
        // require(totalSupply() + 1 <= maxSupply(), "9c7b6c43");
        _safeMint(to, totalSupply() + 1);
    }

    function mintMulti(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, _msgSender()), "24113153");
        // require(totalSupply() + amount <= maxSupply(), "9c7b6c43");
        uint256 supply = totalSupply();
        for (uint256 i = 1; i <= amount; i++) {
            _safeMint(to, supply + i);
        }
    }

    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "500c80ca");
        _pause();
    }

    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "500c80ca");
        _unpause();
    }
}
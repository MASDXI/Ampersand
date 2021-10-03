// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721EnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/CountersUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
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
    ReentrancyGuardUpgradeable
{
    /**
     * ERROR code handle
     * CRC32 encode
     */

    function initialize(tokenInfo memory input, address owner)
        public
        virtual
        initializer
    {
        __ERC721PresetMinterPauserAutoId_init(input, owner);
    }

    using CountersUpgradeable for CountersUpgradeable.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    CountersUpgradeable.Counter private _tokenIdTracker;

    struct tokenInfo {
        string _name;
        string _symbol;
        string _baseTokenURI;
        uint256 _totalSupply;
        uint256 _maxPurchase;
        uint256 _price;
        address[] _collaborator;
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
        // _pause(); uncommment this line when `production`
    }

    function buy(uint256 amount)
        public
        payable
        virtual
        nonReentrant
        whenNotPaused
    {
        require(totalSupply() + amount <= token._totalSupply, "1");
        require(amount <= token._maxPurchase, "2");
        require(msg.value >= getPrice() * amount, "3");

        for (uint256 i = 1; i <= amount; i++) {
            _mint(msg.sender, totalSupply() + i);
        }
    }

    function maxPurchase() public view returns (uint256) {
        return token._maxPurchase;
    }

    function setPrice(uint256 newPrice) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "5");
        token._price = newPrice;
    }

    function getPrice() public view returns (uint256) {
        return token._price;
    }

    function withdraw() public payable {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "4");
        // require(address(this).balance > 10000 gwei, "006"); // uncomment this line when `production`
        IFactoryClone factory = IFactoryClone(_factoryAddress);
        uint256 each = ((address(this).balance *
            ((100 - factory.fees()) / 100)) / token._collaborator.length);

        for (uint256 i = 0; i < token._collaborator.length; i++) {
            payable(token._collaborator[i]).transfer(each);
        }

        payable(factory.feesAddress()).transfer(address(this).balance);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return token._baseTokenURI;
    }

    function mint(address to) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "6");
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }

    function mintMulti(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, _msgSender()), "7");
        require(totalSupply() + amount <= token._totalSupply, "1");
        for (uint256 i = 1; i <= amount; i++) {
            _mint(to, totalSupply() + i);
        }
    }

    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "8");
        _pause();
    }

    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "9");
        _unpause();
    }

    function getFactory() public view returns (address) {
        return _factoryAddress;
    }

    function getFactoryManager() public view returns (address) {
        IFactoryClone factory = IFactoryClone(getFactory());
        return factory.feesAddress();
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    )
        internal
        virtual
        override(
            ERC721Upgradeable,
            ERC721EnumerableUpgradeable,
            ERC721PausableUpgradeable
        )
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(
            AccessControlEnumerableUpgradeable,
            ERC721Upgradeable,
            ERC721EnumerableUpgradeable
        )
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    uint256[48] private __gap;
}

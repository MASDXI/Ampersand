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

contract ERC721Preset is
    Initializable,
    ContextUpgradeable,
    AccessControlEnumerableUpgradeable,
    ERC721Upgradeable,
    ERC721EnumerableUpgradeable,
    ERC721PausableUpgradeable,
    ReentrancyGuardUpgradeable
{
    function initialize(
        string memory name,
        string memory symbol,
        string memory baseTokenURI,
        uint256 totalSupply,
        uint256 maxPurchase,
        uint256 price,
        address owner
    ) public virtual initializer {
        __ERC721PresetMinterPauserAutoId_init(
            name,
            symbol,
            baseTokenURI,
            totalSupply,
            maxPurchase,
            price,
            owner
        );
    }

    using CountersUpgradeable for CountersUpgradeable.Counter;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    CountersUpgradeable.Counter private _tokenIdTracker;

    string private _baseTokenURI;
    uint256 private _totalSupply;
    uint256 private _maxPurchase;
    uint256 private _price;

    function __ERC721PresetMinterPauserAutoId_init(
        string memory name,
        string memory symbol,
        string memory baseTokenURI,
        uint256 totalSupply,
        uint256 maxPurchase,
        uint256 price,
        address owner
    ) internal initializer {
        __Context_init_unchained();
        __ERC165_init_unchained();
        __AccessControl_init_unchained();
        __AccessControlEnumerable_init_unchained();
        __ReentrancyGuard_init_unchained();
        __ERC721_init_unchained(name, symbol);
        __ERC721Enumerable_init_unchained();
        __Pausable_init_unchained();
        __ERC721Pausable_init_unchained();
        __ERC721PresetMinterPauserAutoId_init_unchained(
            baseTokenURI,
            price,
            totalSupply,
            maxPurchase,
            owner
        );
    }

    function __ERC721PresetMinterPauserAutoId_init_unchained(
        string memory baseTokenURI,
        uint256 price,
        uint256 totalSupply,
        uint256 maxPurchase,
        address owner
    ) internal initializer {
        _baseTokenURI = baseTokenURI;
        _totalSupply = totalSupply;
        _price = price;
        _maxPurchase = maxPurchase;
        _setupRole(DEFAULT_ADMIN_ROLE, owner);
        _setupRole(MINTER_ROLE, owner);
        _setupRole(PAUSER_ROLE, owner);
        // _pause(); set paused to true `production`
    }

    // function buy(uint amount) public payable virtual nonReentrant {
    //     require(!paused(),"");
    //     require(totalSupply() + amount <= maxSupply, "002");
    //     require(_msgSender() >= price() * num, "005");
    //     for (uint256 i = 1; i <= amount; i++) {
    //         TODO do something here
    //         _mint(_msgSender(), supply + i);
    //     }
    // }

    function setPrice(uint256 price) public {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()),
            "ERC721Preset: must have admin role to mint"
        );
        _price = price;
    }

    function price() public view returns (uint256) {
        return _price;
    }

    // function giveAway(address to,uint amount) public {
    //      require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()),"ERC721Preset: must have admin role to mint");
    //      TODO do something here
    // }

    function _baseURI() internal view virtual override returns (string memory) {
        require(
            hasRole(DEFAULT_ADMIN_ROLE, _msgSender()),
            "ERC721Preset: must have admin role to mint"
        );
        return _baseTokenURI;
    }

    function mint(address to) public virtual {
        require(
            hasRole(MINTER_ROLE, _msgSender()),
            "ERC721Preset: must have minter role to mint"
        );
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }

    function pause() public virtual {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "ERC721Preset: must have pauser role to pause"
        );
        _pause();
    }

    function unpause() public virtual {
        require(
            hasRole(PAUSER_ROLE, _msgSender()),
            "ERC721Preset: must have pauser role to unpause"
        );
        _unpause();
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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IFactoryClone {

    function fees() external view returns (uint256);
    function feesAddress() external view returns (address);

    /**
     * @dev Emitted when createToken
     * a call to {approve}. `value` is the new allowance.
     */
    event TokenCreated(address indexed clone);

    
    /**
     * @dev Emitted when set new createdToken fees
     */
    event FeesUpdated(uint amount);

}
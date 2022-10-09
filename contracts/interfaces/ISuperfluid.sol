// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface ISuperfluid {
    function upgrade(uint256 _amount) external;

    function downgrade(uint256 _amount) external;
}

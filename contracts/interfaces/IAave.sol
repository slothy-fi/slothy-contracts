// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IAave {
    function supply(
        address _asset,
        uint256 _amount,
        address _onBehalfOf,
        uint16 _referralCode
    ) external;

    function withdraw(
        address _asset,
        uint256 _amount,
        address _to
    ) external;
}

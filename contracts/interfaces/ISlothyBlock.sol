// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface ISlothyBlock {
    function run(bytes32[] memory _args) external returns (bool _success);

    function requestERC20Approval(address _token, uint256 _amount) external;
}

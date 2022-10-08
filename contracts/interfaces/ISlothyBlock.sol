// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
interface ISlothyBlock {
    function run(bytes32[] memory _args) external returns (bool _success);

    function requestERC20Approval(address _token, uint256 _amount) external;

    function argToAddress(bytes32 _arg)
        external
        pure
        returns (address _address);

    function argToUint256(bytes32 _arg)
        external
        pure
        returns (uint256 _uint256);
}

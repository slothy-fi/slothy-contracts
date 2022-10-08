// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract SlothyHelpers {
    struct Approval {
        address token;
        address spender;
        uint256 amount;
    }

    struct Action {
        address target;
        bytes32[] data;
    }
}

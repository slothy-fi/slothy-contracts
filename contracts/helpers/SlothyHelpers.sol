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

    function argToAddress(bytes32 _arg)
        external
        pure
        returns (address _address)
    {
        _address = address(uint160(uint256(_arg)));
    }

    function argToUint256(bytes32 _arg)
        external
        pure
        returns (uint256 _uint256)
    {
        _uint256 = uint256(_arg);
    }
}

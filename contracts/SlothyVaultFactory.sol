// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {BaseSlothyVault} from "./BaseSlothyVault.sol";
import {SlothyHelpers} from "./helpers/SlothyHelpers.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
contract SlothyVaultFactory is Ownable, SlothyHelpers {
    bool public deprecated;

    constructor() {
        deprecated = false;
    }

    function newVault(
        address _startingToken,
        uint256 _startingTokenAmount,
        address[] memory _supportedTokens,
        Approval[] memory _approvals,
        Action[] memory _beforeLoop,
        Action[] memory _loop,
        uint256 _waitTime
    ) public {
        new BaseSlothyVault(
            _startingToken,
            _startingTokenAmount,
            _supportedTokens,
            _approvals,
            _beforeLoop,
            _loop,
            _waitTime
        );
    }
}

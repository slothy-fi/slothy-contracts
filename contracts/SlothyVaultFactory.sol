// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {BaseSlothyVault} from "./BaseSlothyVault.sol";
import {SlothyHelpers} from "./helpers/SlothyHelpers.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
contract SlothyVaultFactory is Ownable, SlothyHelpers {
    bool public deprecated;

    // address to strategy mapping
    mapping(address => address) userToVault;

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
        require(
            userToVault[msg.sender] == address(0),
            "Vault for this user already exists."
        );

        userToVault[msg.sender] = address(
            new BaseSlothyVault(
                _startingToken,
                _startingTokenAmount,
                _supportedTokens,
                _approvals,
                _beforeLoop,
                _loop,
                _waitTime
            )
        );
    }
}

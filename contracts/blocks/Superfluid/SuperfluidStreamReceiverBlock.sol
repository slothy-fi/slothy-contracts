// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SuperfluidStreamReceiverBlock is BaseSlothyBlock {
    function run(bytes32[] memory _args) public returns (bool _success) {
        // No action required, stream directly goes to vault

        emit SuperfluidStreamReceiverBlockEvent(msg.sender);
        return true;
    }

    event SuperfluidStreamReceiverBlockEvent(address indexed _vaultAddress);
}

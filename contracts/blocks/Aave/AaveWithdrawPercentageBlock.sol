// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IAave} from "../../interfaces/IAave.sol";

contract AaveWithdrawAllBlock is BaseSlothyBlock {
    address internal constant AAVE_POOL =
        0x794a61358D6845594F94dc1DB02A252b5b4814aD;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _assetAddress
         * @dev _args[1] = _receiptTokenAddress
         * @dev _args[2] = _percentage (100% = 10000)
         */

        address _assetAddress = this.argToAddress(_args[0]);
        address _receiptTokenAddress = this.argToAddress(_args[1]);
        uint256 _percentage = this.argToUint256(_args[2]);

        uint256 amountToWithdraw = (IERC20(_assetAddress).balanceOf(
            msg.sender
        ) * _percentage) / 10000;

        // move receipt token address to this contract
        IERC20(_receiptTokenAddress).transferFrom(
            msg.sender,
            address(this),
            amountToWithdraw
        );

        IAave(AAVE_POOL).withdraw(_assetAddress, amountToWithdraw, msg.sender);

        emit AaveWithdrawPercentageBlockEvent(
            msg.sender,
            _assetAddress,
            amountToWithdraw,
            _percentage
        );

        return true;
    }

    event AaveWithdrawPercentageBlockEvent(
        address indexed _vaultAddress,
        address _assetAddress,
        uint256 _amount,
        uint256 _percentage
    );
}

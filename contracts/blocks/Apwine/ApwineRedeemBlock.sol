// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IApwine} from "../../interfaces/IApwine.sol";

contract ApwineRedeemBlock is BaseSlothyBlock {
    address internal constant CONTROLLER =
        0x4bA30FA240047c17FC557b8628799068d4396790;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _outputTokenAddress
         * @dev _args[1] = _vaultAddress
         * @dev _args[2] = _principalToken
         * @dev _args[3] = _futureYieldToken
         * @dev _args[4] = _slothyVaultAddress
         */

        address _outputTokenAddress = this.argToAddress(_args[0]);
        address _vaultAddress = this.argToAddress(_args[1]);
        address _principalToken = this.argToAddress(_args[2]);
        address _futureYieldToken = this.argToAddress(_args[3]);
        address _slothyVaultAddress = this.argToAddress(_args[4]);

        // require msg sender to be token destination
        require(_slothyVaultAddress == msg.sender, "Not slothy vault");

        // borrow from vault
        IERC20(_principalToken).transferFrom(
            _slothyVaultAddress,
            address(this),
            IERC20(_principalToken).balanceOf(_slothyVaultAddress)
        );
        IERC20(_futureYieldToken).transferFrom(
            _slothyVaultAddress,
            address(this),
            IERC20(_futureYieldToken).balanceOf(_slothyVaultAddress)
        );

        // withdraw from to Apwine
        IApwine(CONTROLLER).withdraw(
            _vaultAddress,
            IERC20(_principalToken).balanceOf(address(this)) //! MIGHT BE WRONG, LOOK IF CAN CALCULATE PREDICTED AMOUNT OUT
        );

        // transfer output token back to slothy vault
        IERC20(_outputTokenAddress).transfer(
            _slothyVaultAddress,
            IERC20(_outputTokenAddress).balanceOf(address(this))
        );

        return true;
    }
}

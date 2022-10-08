// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "./BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IApwine} from "./interfaces/IApwine.sol";

contract ApwineDepositBlock is BaseSlothyBlock {
    address internal constant CONTROLLER =
        0x4bA30FA240047c17FC557b8628799068d4396790;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _tokenAddress
         * @dev _args[1] = _vaultAddress
         * @dev _args[2] = Principal Token
         * @dev _args[3] = Future yield token
         * @dev _args[4] = _slothyVaultAddress
         */

        address _tokenAddress = this.argToAddress(_args[0]);
        address _vaultAddress = this.argToAddress(_args[1]);
        uint256 _amount = IERC20(_tokenAddress).balanceOf(address(this));
        address _principalToken = this.argToAddress(_args[2]);
        address _futureYieldToken = this.argToAddress(_args[3]);
        address _slothyVaultAddress = this.argToAddress(_args[4]);

        //TODO borrow from vault
        IERC20(_tokenAddress).approve(CONTROLLER, _amount);
        IApwine(CONTROLLER).deposit(_vaultAddress, _amount);

        //
        IERC20(_principalToken).transfer(
            _slothyVaultAddress,
            IERC20(_principalToken).balanceOf(address(this))
        );
        IERC20(_futureYieldToken).transfer(
            _slothyVaultAddress,
            IERC20(_principalToken).balanceOf(address(this))
        );

        return true;
    }
}

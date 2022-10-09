// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ISuperfluid} from "../../interfaces/ISuperfluid.sol";

contract SuperfluidUnwrapPercentTokenBlock is BaseSlothyBlock {
    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _superTokenAddress
         * @dev _args[1] = _tokenAddress
         * @dev _args[2] = _percent (100% = 10000)
         */

        address _superTokenAddress = this.argToAddress(_args[0]);
        address _tokenAddress = this.argToAddress(_args[1]);
        uint256 _percent = this.argToUint256(_args[2]);

        uint256 _superTokenBalance = (IERC20(_superTokenAddress).balanceOf(
            msg.sender
        ) * _percent) / 10000;

        // take from vault
        IERC20(_superTokenAddress).transferFrom(
            msg.sender,
            address(this),
            _superTokenBalance
        );

        // unwrap
        ISuperfluid(_superTokenAddress).downgrade(_superTokenBalance);

        // send back to vault
        IERC20(_tokenAddress).transfer(
            msg.sender,
            IERC20(_tokenAddress).balanceOf(address(this))
        );

        emit SuperfluidUnwrapPercentTokenBlockEvent(
            msg.sender,
            _superTokenAddress,
            _tokenAddress,
            _percent
        );

        return true;
    }

    event SuperfluidUnwrapPercentTokenBlockEvent(
        address indexed _vaultAddress,
        address _superTokenAddress,
        address _tokenAddress,
        uint256 _percent
    );
}

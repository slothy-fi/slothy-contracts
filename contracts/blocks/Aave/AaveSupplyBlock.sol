// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IAave} from "../../interfaces/IAave.sol";

contract AaveSupplyBlock is BaseSlothyBlock {
    address internal constant AAVE_POOL =
        0x794a61358D6845594F94dc1DB02A252b5b4814aD;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _assetAddress
         * @dev _args[1] = _amount
         */

        address _assetAddress = this.argToAddress(_args[0]);
        uint256 _amount = this.argToUint256(_args[1]);
        uint16 referralCode = 0;

        IAave(AAVE_POOL).supply(
            _assetAddress,
            _amount,
            msg.sender,
            referralCode
        );

        emit AaveSupplyBlockEvent(msg.sender, _assetAddress, _amount);

        return true;
    }

    event AaveSupplyBlockEvent(
        address indexed _vaultAddress,
        address _assetAddress,
        uint256 _amount
    );
}

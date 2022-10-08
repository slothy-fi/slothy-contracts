// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IApwine} from "../../interfaces/IApwine.sol";

contract ApwineSwapUnderlyingForPTBlock is BaseSlothyBlock {
    address internal constant AMM_ROUTER =
        0x790a0cA839DC5E4690C8c58cb57fD2beCA419AFc;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _outputTokenAddress
         * @dev _args[1] = _outputTokenAmount
         * @dev _args[2] = _AMMAddress
         * @dev _args[3] = _underlyingTokenAddress
         * @dev _args[4] = _underlyingTokenAmount
         * @dev _args[5] = _slothyVaultAddress
         */

        address _outputTokenAddress = this.argToAddress(_args[0]);
        uint256 _outputTokenAmount = this.argToUint256(_args[1]);
        address _AMMAddress = this.argToAddress(_args[2]);
        address _underlyingTokenAddress = this.argToAddress(_args[3]);
        uint256 _underlyingTokenAmount = this.argToUint256(_args[4]);
        address _slothyVaultAddress = this.argToAddress(_args[5]);

        // require msg sender to be token destination
        require(_slothyVaultAddress == msg.sender, "Not slothy vault");

        // borrow from vault
        IERC20(_underlyingTokenAddress).transferFrom(
            _slothyVaultAddress,
            address(this),
            _underlyingTokenAmount
        );

        // swap
        IERC20(_underlyingTokenAddress).approve(
            AMM_ROUTER,
            _underlyingTokenAmount
        );

        uint256[] memory _pool = new uint256[](1);
        uint256[] memory _direction = new uint256[](2);
        _direction[0] = 1;

        IApwine(AMM_ROUTER).swapExactAmountIn(
            _AMMAddress,
            _pool, // Pool 0 is PT/Underlying, Pool 1 is PT/FYT
            _direction, // Token 0 is always PT. Here, we swap from Underlying to PT
            _underlyingTokenAmount,
            _outputTokenAmount,
            msg.sender,
            60,
            address(0)
        );
        //! _minAmountOut and _deadline above should be computed and passed at runtime, by a script or client

        return true;
    }
}

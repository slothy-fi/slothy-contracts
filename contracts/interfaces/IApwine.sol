// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IApwine {
    function deposit(address _vault, uint256 _amount) external;

    function withdraw(address _vault, uint256 _withdrawAmount) external;

    function swapExactAmountIn(
        address _amm,
        uint256[] memory _pool,
        uint256[] memory _direction,
        uint256 _swapAmount,
        uint256 _minAmountOut,
        address destination,
        uint256 _deadline,
        address _final
    ) external;
}

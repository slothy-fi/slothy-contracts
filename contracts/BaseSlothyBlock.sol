// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SlothyHelpers} from "./helpers/SlothyHelpers.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
contract BaseSlothyBlock is Ownable, SlothyHelpers {
    bool public active;

    constructor() {
        active = true;
    }

    // function run(bytes32[] memory _args) external returns (bool _success) {}

    function requestERC20Approval(
        address _token,
        address _to,
        uint256 _amount
    ) external {
        IERC20(_token).approve(_to, _amount);
    }

    function emergencyWithdrawETH() external onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

    function emergencyWithdrawERC20Multiple(address[] memory _tokens)
        public
        onlyOwner
    {
        for (uint256 i = 0; i < _tokens.length; i++) {
            IERC20(_tokens[i]).transfer(
                msg.sender,
                IERC20(_tokens[i]).balanceOf(address(this))
            );
        }
    }

    function toggleActive() external onlyOwner {
        active = !active;
    }
}

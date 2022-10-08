// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ISlothyBlock} from "./interfaces/ISlothyBlock.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
contract BaseSlothyVault is Ownable {
    bool public active;

    address[] public supportedTokens;

    Action[] public loop;

    uint256 public waitTime;

    uint256 public lastRun;

    struct Approval {
        address token;
        address spender;
        uint256 amount;
    }

    struct Action {
        address target;
        bytes32[] data;
    }

    constructor(
        address[] memory _supportedTokens,
        Approval[] memory _approvals,
        Action[] memory _beforeLoop,
        Action[] memory _loop,
        uint256 _waitTime
    ) {
        //TODO way too many loops, optimise
        active = true;
        supportedTokens = _supportedTokens;

        for (uint256 i = 0; i < _approvals.length; i++) {
            IERC20(_approvals[i].token).approve(
                _approvals[i].spender,
                _approvals[i].amount
            );
        }

        for (uint256 i = 0; i < _beforeLoop.length; i++) {
            ISlothyBlock(_beforeLoop[i].target).run(_beforeLoop[i].data);
        }

        for (uint256 i = 0; i < _loop.length; i++) {
            loop.push(_loop[i]);
        }

        waitTime = _waitTime;

        lastRun = block.timestamp;
    }

    function runLoop() public {
        require(active, "Vault is not active");
        require(block.timestamp >= lastRun + waitTime, "Cannot run loop yet");

        for (uint256 i = 0; i < loop.length; i++) {
            ISlothyBlock(loop[i].target).run(loop[i].data);
        }

        lastRun = block.timestamp;
    }

    function emergencyWithdrawETH(uint256 _amount) public onlyOwner {
        payable(msg.sender).transfer(_amount);
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

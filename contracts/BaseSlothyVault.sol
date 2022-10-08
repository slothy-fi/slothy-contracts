// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ISlothyBlock} from "./interfaces/ISlothyBlock.sol";
import {SlothyHelpers} from "./helpers/SlothyHelpers.sol";

// Uncomment this line to use console.log
// import "hardhat/console.sol";
contract BaseSlothyVault is Ownable, SlothyHelpers {
    bool public active;

    address[] public supportedTokens;

    Action[] public loop;

    uint256 public waitTime;

    uint256 public lastRun;

    constructor(
        address _startingToken,
        uint256 _startingTokenAmount,
        address[] memory _supportedTokens,
        Approval[] memory _approvals,
        Action[] memory _beforeLoop,
        Action[] memory _loop,
        uint256 _waitTime
    ) {
        IERC20(_startingToken).transferFrom(
            msg.sender,
            address(this),
            _startingTokenAmount
        );

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

    function stop() public onlyOwner {
        active = false;
        for (uint256 i = 0; i < supportedTokens.length; i++) {
            IERC20(supportedTokens[i]).transfer(
                msg.sender,
                IERC20(supportedTokens[i]).balanceOf(address(this))
            );
        }
    }

    function toggleActive() external onlyOwner {
        active = !active;
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleSendAllToBlock is BaseSlothyBlock {
    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _tokenAddress
         * @dev _args[1] = _recipientAddress
         */

        address _tokenAddress = this.argToAddress(_args[0]);
        address _recipientAddress = this.argToAddress(_args[1]);
        uint256 tokenAmount = IERC20(_tokenAddress).balanceOf(msg.sender);

        // take from vault
        IERC20(_tokenAddress).transferFrom(
            msg.sender,
            address(this),
            tokenAmount
        );

        // send to recipient
        IERC20(_tokenAddress).transfer(_recipientAddress, tokenAmount);

        emit SimpleSendToBlockEvent(
            msg.sender,
            _tokenAddress,
            tokenAmount,
            _recipientAddress
        );

        return true;
    }

    event SimpleSendToBlockEvent(
        address indexed _vaultAddress,
        address _tokenAddress,
        uint256 _tokenAmount,
        address _recipientAddress
    );
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleSendToBlock is BaseSlothyBlock {
    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _tokenAddress
         * @dev _args[1] = _tokenAmount
         * @dev _args[2] = _recipientAddress
         */

        address _tokenAddress = this.argToAddress(_args[0]);
        uint256 _tokenAmount = this.argToUint256(_args[1]);
        address _recipientAddress = this.argToAddress(_args[2]);

        // take from vault
        IERC20(_tokenAddress).transferFrom(
            msg.sender,
            address(this),
            _tokenAmount
        );

        // send to recipient
        IERC20(_tokenAddress).transfer(_recipientAddress, _tokenAmount);

        emit SimpleSendToBlockEvent(
            msg.sender,
            _tokenAddress,
            _tokenAmount,
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

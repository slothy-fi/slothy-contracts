// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import {BaseSlothyBlock} from "../../BaseSlothyBlock.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SimpleSendToBlock is BaseSlothyBlock {
    address internal constant CONTROLLER =
        0x4bA30FA240047c17FC557b8628799068d4396790;

    function run(bytes32[] memory _args) public returns (bool _success) {
        /**
         * @dev _args[0] = _tokenAddress
         * @dev _args[1] = _tokenAmount
         * @dev _args[2] = _recipientAddress
         * @dev _args[3] = _slothyVaultAddress
         */

        address _tokenAddress = this.argToAddress(_args[0]);
        uint256 _tokenAmount = this.argToUint256(_args[1]);
        address _recipientAddress = this.argToAddress(_args[2]);
        address _slothyVaultAddress = this.argToAddress(_args[3]);

        // require msg sender to be token destination
        require(_slothyVaultAddress == msg.sender, "Not slothy vault");

        // take from vault
        IERC20(_tokenAddress).transferFrom(
            _slothyVaultAddress,
            address(this),
            _tokenAmount
        );

        // send to recipient
        IERC20(_tokenAddress).transfer(_recipientAddress, _tokenAmount);

        return true;
    }
}

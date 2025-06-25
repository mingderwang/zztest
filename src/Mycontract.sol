// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract MyContract {
    using ECDSA for bytes32;

    function test(
        bytes memory signature,
        address from,
        address to
    ) public view returns (bool) {
        bytes32 messageHash = keccak256(abi.encodePacked(from, to));
        bytes32 message = messageHash.toEthSignedMessageHash();
        address recoveredAddress = ECDSA.recover(message, signature);

        require(recoveredAddress == msg.sender, "Invalid signature");

        return true;
    }
}

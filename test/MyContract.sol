// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol"; // Add this import
import "../src/MyContract.sol";

contract MyContractTest is Test {
    using ECDSA for bytes32;

    MyContract myContract;
    uint256 privateKey = 0xabc123;
    address signer;
    address from = address(0x5678);
    address to = address(0x9abc);

    function setUp() public {
        myContract = new MyContract();
        signer = vm.addr(privateKey);
    }

    function testValidSignature() public {
        bytes32 messageHash = keccak256(abi.encodePacked(from, to));
        bytes32 ethSignedMessageHash = messageHash.toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, ethSignedMessageHash);
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.prank(signer);
        bool result = myContract.test(signature, from, to);
        assertTrue(result);
    }
}

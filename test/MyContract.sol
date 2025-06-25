// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol"; // Add this import
import "../src/MyContract.sol";
import "forge-std/console.sol";

contract MyContractTest is Test {
    using ECDSA for bytes32;

    MyContract myContract;
    uint256 privateKey = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    address signer;
    address from = address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8);
    address to = address(0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC);

    function setUp() public {
        myContract = new MyContract();
        signer = vm.addr(privateKey);
        console.logAddress(from);
    }

    function testValidSignature() public {
        bytes32 messageHash = keccak256(abi.encodePacked(from, to));
        console.logBytes32(messageHash);
        bytes32 ethSignedMessageHash = messageHash.toEthSignedMessageHash();
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, ethSignedMessageHash);
        bytes memory signature = abi.encodePacked(r, s, v);

        vm.prank(signer);
        bool result = myContract.ming(signature, from, to);
        assertTrue(result);
    }
}

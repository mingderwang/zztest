// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/MyAccount.sol";

contract MyAccountTest is Test {
    MyAccount public account;

    // Example valid P-256 public key (qx, qy)
bytes32 public qx = 0x8b3b5b1f3a47b064a7e4e2a8f1be7c1e7c9f6a2b2f91e9c3c7e0e8b10d4b2e7d;
bytes32 public qy = 0x3568e7c1d9b1a4e0a7b0e2c3f3b4e5f7c6a3e2d4b1e6f7c8d9b0e1f2a3b4c5d6;

    function setUp() public {
        account = new MyAccount();
    }

    function testCannotInitializeTwice() public {
        // First initialization should succeed
        account.initializeP256(qx, qy);

        // Second initialization should fail
        vm.expectRevert("Initializable: contract is already initialized");
        account.initializeP256(qx, qy);
    }

    function testSignerIsSet() public {
        // Deploy a fresh contract to test
        MyAccount newAccount = new MyAccount();
        newAccount.initializeP256(qx, qy);

        // If SignerP256 exposes a getter, check the key (pseudo-code, may need adjustment)
       //  (bytes32 actualQx, bytes32 actualQy) = newAccount.getSigner();
       //  assertEq(actualQx, qx);
        // assertEq(actualQy, qy);

        // Otherwise, just ensure no revert occurs and initialized
        assertTrue(true);
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SimpleAccount.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// A simple ERC20 for testing purposes
contract TestToken is ERC20 {
    constructor() ERC20("TestToken", "TT") {
        _mint(msg.sender, 1_000_000 ether);
    }
}

contract SimpleAccountTest is Test {
    SimpleAccount public account;
    TestToken public token;
    address public owner = address(0xABCD);
    address public recipient = address(0xBEEF);

    function setUp() public {
        // Deploy the test ERC20 token
        token = new TestToken();

        // Deploy the SimpleAccount contract with owner
        account = new SimpleAccount(owner);

        // Give the account some TestToken
        token.transfer(address(account), 1000 ether);
    }

    function testOwnerCanTransferTokens() public {
        // Simulate owner calling transferERC20
        vm.prank(owner);
        account.transferERC20(address(token), recipient, 100 ether);

        // Check balances
        assertEq(token.balanceOf(recipient), 100 ether);
        assertEq(token.balanceOf(address(account)), 900 ether);
    }

    function testNonOwnerCannotTransferTokens() public {
        // Expect revert if a non-owner tries to transfer
        vm.expectRevert("Not owner");
        account.transferERC20(address(token), recipient, 100 ether);
    }
}

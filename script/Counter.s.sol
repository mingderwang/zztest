// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyContract} from "../src/MyContract.sol";

contract MyContractScript is Script {
    MyContract public myc;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        myc = new MyContract();

        vm.stopBroadcast();
    }
}

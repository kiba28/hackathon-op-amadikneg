// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {AnticipayChain} from "../src/AnticipayChain.sol";

contract Local is Script {
    AnticipayChain anticipayChain;

    function setUp() public {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);

        anticipayChain = new AnticipayChain(address(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266), address(0x70997970C51812dc3A010C7d01b50e0d17dc79C8), 1 ether);
        console2.log("AnticipayChain address: ", address(anticipayChain));

        vm.stopBroadcast();
    }
}

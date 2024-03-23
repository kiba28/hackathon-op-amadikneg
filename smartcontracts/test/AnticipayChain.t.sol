// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {BaseSetup} from "./BaseSetup.t.sol";

contract AnticipayChainTest is BaseSetup {
    function setUp() public override {
        BaseSetup.setUp();
    }

    function test_RequestFoundPayment() public {
        vm.startPrank(deliveryCompany);
        anticipay.requestFoundPayment();
        vm.stopPrank();

        assertTrue(anticipay.requireFoundPaid());
    }

    /* function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    } */
}

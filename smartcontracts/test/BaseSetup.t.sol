// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AnticipayChain} from "../src/AnticipayChain.sol";
import {Utils} from "./Utils.t.sol";

contract BaseSetup is Utils {
    AnticipayChain anticipay;

    address[] _users;
    address controller;
    address deliveryCompany;
    address found;

    function setUp() public virtual {
        _users = createUsers(3);

        controller = _users[0];
        deliveryCompany = _users[1];
        found = _users[2];

        vm.label(controller, "CONTROLLER");
        vm.label(deliveryCompany, "DELIVERYCOMPANY");
        vm.label(found, "FOUND");

        vm.startPrank(controller);
        anticipay = new AnticipayChain(deliveryCompany, found, 1);
        vm.stopPrank();
    }

    function test_basesetup_just_for_pass_in_converage() public {}
}

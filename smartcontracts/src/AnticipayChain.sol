// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AnticipayChain {
    address public contractor;
    address payable public deliveryCompany;
    address payable public found;
    uint256 private contractValue;
    bool public foundPaid;
    bool public requireFoundPaid;

    // This notify the service that the contract is sucessefully deployed
    event ContractDeployed(address indexed deployer, uint256 timestamp);

    // This event is a callback to the external api/service that is connected to the contract.
    event MoneyAssinged(address sender, address reciver, uint256 amount);

    constructor(address _deliveryCompany, address _found, uint256 _contractValue) {
        contractor = msg.sender;
        deliveryCompany = payable(_deliveryCompany); // This need to be setted for every deploy
        found = payable(_found); // This need to be setted for every deploy
        contractValue = _contractValue; // This need to be setted for every deploy
        foundPaid = false;
        requireFoundPaid = false;

        emit ContractDeployed(address(this), block.timestamp);
    }

    function requestFoundPayment() external {
        require(msg.sender == deliveryCompany, "Need to be the delivery company");
        requireFoundPaid = true;
    }

    function receiveFound() external payable {
        require(requireFoundPaid, "Found payment not required.");
        require(msg.value >= (contractValue * 98) / 100, "Insufficient funds");
        require(msg.sender == found, "Need to be the found.");
        foundPaid = true;

        deliveryCompany.transfer(msg.value);
        emit MoneyAssinged(msg.sender, deliveryCompany, msg.value);
    }

    receive() external payable {
        require(msg.value == contractValue, "Amount must be 1 ether");
        require(msg.sender == contractor, "The user need to be receipt");

        if (foundPaid) {
            found.transfer(msg.value);
            emit MoneyAssinged(msg.sender, found, msg.value);
        } else {
            deliveryCompany.transfer(msg.value);
            emit MoneyAssinged(msg.sender, deliveryCompany, msg.value);
        }
    }
}

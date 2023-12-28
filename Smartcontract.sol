// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract VendingMachine {
    address public owner; // Contract owner
    mapping(address => uint) public cupcakeBalances; // Cupcake balances per address

    constructor() {
        owner = msg.sender; // Set the contract owner
    }

    // Function to buy cupcakes
    function buyCupcakes(uint quantity) external payable {
        require(quantity > 0, "Invalid quantity");
        uint pricePerCupcake = 0.01 ether; // Price per cupcake in Ether

        // Calculate total cost
        uint totalCost = pricePerCupcake * quantity;
        require(msg.value >= totalCost, "Insufficient funds");

        // Update cupcake balances
        cupcakeBalances[msg.sender] += quantity;
    }

    // Function to withdraw cupcakes
    function withdrawCupcakes(uint quantity) external {
        require(cupcakeBalances[msg.sender] >= quantity, "Insufficient cupcakes");
        cupcakeBalances[msg.sender] -= quantity;
        payable(msg.sender).transfer(quantity * 0.01 ether); // Refund in Ether
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";
import { Example } from "../contracts/Example.sol";

contract ExampleTest is Test {
    Example public example;
    address public owner;
    address public feeRecipient;
    address public user1;
    address public user2;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function setUp() public {
        owner = address(this);
        feeRecipient = makeAddr("feeRecipient");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        example = new Example(feeRecipient);

        // Fund users
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);
    }

    // ============================================
    // Constructor Tests
    // ============================================

    function test_Constructor() public view {
        assertEq(example.owner(), owner);
        assertEq(example.feeRecipient(), feeRecipient);
        assertEq(example.totalDeposits(), 0);
    }

    function test_Constructor_RevertZeroAddress() public {
        vm.expectRevert("Zero address");
        new Example(address(0));
    }

    // ============================================
    // Deposit Tests
    // ============================================

    function test_Deposit() public {
        uint256 depositAmount = 1 ether;
        uint256 expectedFee = (depositAmount * 100) / 10000; // 1%
        uint256 expectedNet = depositAmount - expectedFee;

        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit Deposited(user1, expectedNet);
        example.deposit{ value: depositAmount }();

        assertEq(example.balances(user1), expectedNet);
        assertEq(example.totalDeposits(), expectedNet);
        assertEq(feeRecipient.balance, expectedFee);
    }

    function test_Deposit_RevertZeroAmount() public {
        vm.prank(user1);
        vm.expectRevert(Example.ZeroAmount.selector);
        example.deposit{ value: 0 }();
    }

    function testFuzz_Deposit(uint256 amount) public {
        vm.assume(amount > 0 && amount <= 100 ether);
        vm.deal(user1, amount);

        uint256 expectedFee = (amount * 100) / 10000;
        uint256 expectedNet = amount - expectedFee;

        vm.prank(user1);
        example.deposit{ value: amount }();

        assertEq(example.balances(user1), expectedNet);
    }

    // ============================================
    // Withdraw Tests
    // ============================================

    function test_Withdraw() public {
        // Setup: deposit first
        vm.prank(user1);
        example.deposit{ value: 1 ether }();
        uint256 balance = example.balances(user1);

        uint256 userBalanceBefore = user1.balance;

        vm.prank(user1);
        vm.expectEmit(true, false, false, true);
        emit Withdrawn(user1, balance);
        example.withdraw(balance);

        assertEq(example.balances(user1), 0);
        assertEq(user1.balance, userBalanceBefore + balance);
    }

    function test_Withdraw_RevertZeroAmount() public {
        vm.prank(user1);
        vm.expectRevert(Example.ZeroAmount.selector);
        example.withdraw(0);
    }

    function test_Withdraw_RevertInsufficientBalance() public {
        vm.prank(user1);
        vm.expectRevert(Example.InsufficientBalance.selector);
        example.withdraw(1 ether);
    }

    function test_Withdraw_Partial() public {
        vm.prank(user1);
        example.deposit{ value: 1 ether }();
        uint256 balance = example.balances(user1);
        uint256 withdrawAmount = balance / 2;

        vm.prank(user1);
        example.withdraw(withdrawAmount);

        assertEq(example.balances(user1), balance - withdrawAmount);
    }

    // ============================================
    // Access Control Tests
    // ============================================

    function test_SetFeeRecipient() public {
        address newRecipient = makeAddr("newRecipient");
        example.setFeeRecipient(newRecipient);
        assertEq(example.feeRecipient(), newRecipient);
    }

    function test_SetFeeRecipient_RevertNotOwner() public {
        vm.prank(user1);
        vm.expectRevert();
        example.setFeeRecipient(user1);
    }

    function test_SetFeeRecipient_RevertZeroAddress() public {
        vm.expectRevert("Zero address");
        example.setFeeRecipient(address(0));
    }

    // ============================================
    // Reentrancy Tests
    // ============================================

    function test_Withdraw_ReentrancyProtection() public {
        ReentrancyAttacker attacker = new ReentrancyAttacker(address(example));
        vm.deal(address(attacker), 2 ether);

        // Attacker deposits
        attacker.deposit{ value: 1 ether }();

        // Attack should fail due to reentrancy guard
        vm.expectRevert();
        attacker.attack();
    }
}

// Reentrancy attacker for testing
contract ReentrancyAttacker {
    Example public target;
    uint256 public attackCount;

    constructor(address _target) {
        target = Example(_target);
    }

    function deposit() external payable {
        target.deposit{ value: msg.value }();
    }

    function attack() external {
        uint256 balance = target.balances(address(this));
        target.withdraw(balance);
    }

    receive() external payable {
        if (attackCount < 5) {
            attackCount++;
            uint256 balance = target.balances(address(this));
            if (balance > 0) {
                target.withdraw(balance);
            }
        }
    }
}

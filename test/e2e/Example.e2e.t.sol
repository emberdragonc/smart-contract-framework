// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { Test, console } from "forge-std/Test.sol";
import { Example } from "../../contracts/Example.sol";

/**
 * @title E2E Integration Tests
 * @notice Tests that run against a forked network for realistic scenarios
 * @dev Run with: forge test --match-path "test/e2e/*" --fork-url $BASE_SEPOLIA_RPC_URL
 */
contract ExampleE2ETest is Test {
    Example public example;

    // Real addresses from Base network
    address public constant WETH = 0x4200000000000000000000000000000000000006;

    address public deployer;
    address public feeRecipient;
    address public user1;
    address public user2;

    function setUp() public {
        // Create fresh addresses
        deployer = makeAddr("deployer");
        feeRecipient = makeAddr("feeRecipient");
        user1 = makeAddr("user1");
        user2 = makeAddr("user2");

        // Fund accounts
        vm.deal(deployer, 10 ether);
        vm.deal(user1, 10 ether);
        vm.deal(user2, 10 ether);

        // Deploy contract
        vm.prank(deployer);
        example = new Example(feeRecipient);
    }

    // ============================================
    // E2E Flow Tests
    // ============================================

    function test_E2E_FullUserJourney() public {
        // User1 deposits
        vm.prank(user1);
        example.deposit{ value: 1 ether }();

        // User2 deposits
        vm.prank(user2);
        example.deposit{ value: 2 ether }();

        // Check state
        uint256 user1Balance = example.balances(user1);
        uint256 user2Balance = example.balances(user2);
        assertGt(user1Balance, 0);
        assertGt(user2Balance, 0);

        // Fees accumulated
        assertGt(feeRecipient.balance, 0);
        console.log("Fee recipient balance:", feeRecipient.balance);

        // User1 partial withdraw
        vm.prank(user1);
        example.withdraw(user1Balance / 2);

        // User2 full withdraw
        vm.prank(user2);
        example.withdraw(user2Balance);

        // Final state
        assertEq(example.balances(user2), 0);
        assertGt(example.balances(user1), 0);

        console.log("Total deposits remaining:", example.totalDeposits());
    }

    function test_E2E_MultipleDepositsAndWithdraws() public {
        // Simulate many transactions
        for (uint256 i = 0; i < 10; i++) {
            vm.prank(user1);
            example.deposit{ value: 0.1 ether }();
        }

        uint256 totalBalance = example.balances(user1);
        console.log("User1 total after 10 deposits:", totalBalance);

        // Withdraw in chunks
        for (uint256 i = 0; i < 5; i++) {
            vm.prank(user1);
            example.withdraw(totalBalance / 10);
        }

        console.log("User1 remaining:", example.balances(user1));
    }

    function test_E2E_GasEstimates() public {
        // Measure gas for common operations
        uint256 gasBefore = gasleft();

        vm.prank(user1);
        example.deposit{ value: 1 ether }();

        uint256 depositGas = gasBefore - gasleft();
        console.log("Deposit gas:", depositGas);

        // Get balance first, then prank for withdraw
        uint256 userBalance = example.balances(user1);

        gasBefore = gasleft();
        vm.prank(user1);
        example.withdraw(userBalance);

        uint256 withdrawGas = gasBefore - gasleft();
        console.log("Withdraw gas:", withdrawGas);

        // Gas should be reasonable (under 150k for simple operations)
        assertLt(depositGas, 150000);
        assertLt(withdrawGas, 100000);
    }

    // ============================================
    // Stress Tests
    // ============================================

    function test_E2E_HighVolume() public {
        // Simulate high volume
        address[] memory users = new address[](50);

        for (uint256 i = 0; i < 50; i++) {
            users[i] = makeAddr(string(abi.encodePacked("user", i)));
            vm.deal(users[i], 1 ether);

            vm.prank(users[i]);
            example.deposit{ value: 0.5 ether }();
        }

        console.log("Total deposits after 50 users:", example.totalDeposits());
        console.log("Fees collected:", feeRecipient.balance);

        // All users withdraw
        for (uint256 i = 0; i < 50; i++) {
            uint256 balance = example.balances(users[i]);
            if (balance > 0) {
                vm.prank(users[i]);
                example.withdraw(balance);
            }
        }

        assertEq(example.totalDeposits(), 0);
    }
}

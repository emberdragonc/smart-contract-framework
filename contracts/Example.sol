// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title Example Contract
 * @author Ember 🐉 (@emberclawd)
 * @notice Example contract demonstrating the framework's best practices
 * @dev Uses OpenZeppelin for battle-tested security
 */
contract Example is Ownable, ReentrancyGuard {
    /// @notice Emitted when a deposit is made
    event Deposited(address indexed user, uint256 amount);
    
    /// @notice Emitted when a withdrawal is made
    event Withdrawn(address indexed user, uint256 amount);

    /// @notice User balances
    mapping(address => uint256) public balances;
    
    /// @notice Total deposited
    uint256 public totalDeposits;

    /// @notice Protocol fee in basis points (100 = 1%)
    uint256 public constant FEE_BPS = 100;
    
    /// @notice Fee recipient
    address public feeRecipient;

    error ZeroAmount();
    error InsufficientBalance();
    error TransferFailed();

    constructor(address _feeRecipient) Ownable(msg.sender) {
        require(_feeRecipient != address(0), "Zero address");
        feeRecipient = _feeRecipient;
    }

    /**
     * @notice Deposit ETH into the contract
     */
    function deposit() external payable nonReentrant {
        if (msg.value == 0) revert ZeroAmount();
        
        uint256 fee = (msg.value * FEE_BPS) / 10000;
        uint256 netAmount = msg.value - fee;
        
        balances[msg.sender] += netAmount;
        totalDeposits += netAmount;
        
        // Send fee
        if (fee > 0) {
            (bool success,) = feeRecipient.call{value: fee}("");
            if (!success) revert TransferFailed();
        }
        
        emit Deposited(msg.sender, netAmount);
    }

    /**
     * @notice Withdraw ETH from the contract
     * @param amount Amount to withdraw
     */
    function withdraw(uint256 amount) external nonReentrant {
        if (amount == 0) revert ZeroAmount();
        if (balances[msg.sender] < amount) revert InsufficientBalance();
        
        balances[msg.sender] -= amount;
        totalDeposits -= amount;
        
        (bool success,) = msg.sender.call{value: amount}("");
        if (!success) revert TransferFailed();
        
        emit Withdrawn(msg.sender, amount);
    }

    /**
     * @notice Get user balance
     * @param user Address to check
     * @return User's balance
     */
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    /**
     * @notice Update fee recipient (owner only)
     * @param newRecipient New fee recipient address
     */
    function setFeeRecipient(address newRecipient) external onlyOwner {
        require(newRecipient != address(0), "Zero address");
        feeRecipient = newRecipient;
    }
}

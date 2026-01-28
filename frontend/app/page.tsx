'use client';

import { useState } from 'react';
import { ConnectButton } from '@rainbow-me/rainbowkit';
import { useAccount, useReadContract, useWriteContract, useWaitForTransactionReceipt } from 'wagmi';
import { parseEther, formatEther } from 'viem';
import { track } from '@vercel/analytics';

// Contract ABI (minimal for Example contract)
const CONTRACT_ABI = [
  {
    name: 'deposit',
    type: 'function',
    stateMutability: 'payable',
    inputs: [],
    outputs: [],
  },
  {
    name: 'withdraw',
    type: 'function',
    stateMutability: 'nonpayable',
    inputs: [{ name: 'amount', type: 'uint256' }],
    outputs: [],
  },
  {
    name: 'balances',
    type: 'function',
    stateMutability: 'view',
    inputs: [{ name: '', type: 'address' }],
    outputs: [{ type: 'uint256' }],
  },
  {
    name: 'totalDeposits',
    type: 'function',
    stateMutability: 'view',
    inputs: [],
    outputs: [{ type: 'uint256' }],
  },
] as const;

const CONTRACT_ADDRESS = process.env.NEXT_PUBLIC_CONTRACT_ADDRESS as `0x${string}`;

export default function Home() {
  const { address, isConnected } = useAccount();
  const [depositAmount, setDepositAmount] = useState('0.01');
  const [withdrawAmount, setWithdrawAmount] = useState('0.01');

  // Read user balance
  const { data: userBalance, refetch: refetchBalance } = useReadContract({
    address: CONTRACT_ADDRESS,
    abi: CONTRACT_ABI,
    functionName: 'balances',
    args: address ? [address] : undefined,
  });

  // Read total deposits
  const { data: totalDeposits } = useReadContract({
    address: CONTRACT_ADDRESS,
    abi: CONTRACT_ABI,
    functionName: 'totalDeposits',
  });

  // Deposit
  const { writeContract: deposit, data: depositHash, isPending: isDepositing } = useWriteContract();
  const { isLoading: isDepositConfirming, isSuccess: isDepositSuccess } = useWaitForTransactionReceipt({
    hash: depositHash,
  });

  // Withdraw
  const { writeContract: withdraw, data: withdrawHash, isPending: isWithdrawing } = useWriteContract();
  const { isLoading: isWithdrawConfirming, isSuccess: isWithdrawSuccess } = useWaitForTransactionReceipt({
    hash: withdrawHash,
  });

  const handleDeposit = () => {
    // Track event for analytics
    track('deposit_initiated', { amount: depositAmount });
    
    deposit({
      address: CONTRACT_ADDRESS,
      abi: CONTRACT_ABI,
      functionName: 'deposit',
      value: parseEther(depositAmount),
    });
  };

  const handleWithdraw = () => {
    track('withdraw_initiated', { amount: withdrawAmount });
    
    withdraw({
      address: CONTRACT_ADDRESS,
      abi: CONTRACT_ABI,
      functionName: 'withdraw',
      args: [parseEther(withdrawAmount)],
    });
  };

  // Refetch on success
  if (isDepositSuccess || isWithdrawSuccess) {
    refetchBalance();
  }

  return (
    <main className="min-h-screen bg-gray-900 text-white p-8">
      <div className="max-w-2xl mx-auto">
        <div className="flex justify-between items-center mb-8">
          <h1 className="text-3xl font-bold">🐉 Smart Contract Frontend</h1>
          <ConnectButton />
        </div>

        {/* Stats */}
        <div className="grid grid-cols-2 gap-4 mb-8">
          <div className="bg-gray-800 rounded-lg p-4">
            <div className="text-gray-400 text-sm">Your Balance</div>
            <div className="text-2xl font-bold">
              {userBalance ? formatEther(userBalance) : '0'} ETH
            </div>
          </div>
          <div className="bg-gray-800 rounded-lg p-4">
            <div className="text-gray-400 text-sm">Total Deposits</div>
            <div className="text-2xl font-bold">
              {totalDeposits ? formatEther(totalDeposits) : '0'} ETH
            </div>
          </div>
        </div>

        {isConnected ? (
          <div className="space-y-6">
            {/* Deposit */}
            <div className="bg-gray-800 rounded-lg p-6">
              <h2 className="text-xl font-semibold mb-4">Deposit</h2>
              <div className="flex gap-4">
                <input
                  type="number"
                  value={depositAmount}
                  onChange={(e) => setDepositAmount(e.target.value)}
                  className="flex-1 bg-gray-700 rounded px-4 py-2"
                  placeholder="Amount in ETH"
                  step="0.01"
                />
                <button
                  onClick={handleDeposit}
                  disabled={isDepositing || isDepositConfirming}
                  className="bg-blue-600 hover:bg-blue-700 disabled:bg-gray-600 px-6 py-2 rounded font-semibold"
                >
                  {isDepositing ? 'Confirming...' : isDepositConfirming ? 'Processing...' : 'Deposit'}
                </button>
              </div>
              {isDepositSuccess && (
                <p className="text-green-400 mt-2">✓ Deposit successful!</p>
              )}
            </div>

            {/* Withdraw */}
            <div className="bg-gray-800 rounded-lg p-6">
              <h2 className="text-xl font-semibold mb-4">Withdraw</h2>
              <div className="flex gap-4">
                <input
                  type="number"
                  value={withdrawAmount}
                  onChange={(e) => setWithdrawAmount(e.target.value)}
                  className="flex-1 bg-gray-700 rounded px-4 py-2"
                  placeholder="Amount in ETH"
                  step="0.01"
                />
                <button
                  onClick={handleWithdraw}
                  disabled={isWithdrawing || isWithdrawConfirming}
                  className="bg-purple-600 hover:bg-purple-700 disabled:bg-gray-600 px-6 py-2 rounded font-semibold"
                >
                  {isWithdrawing ? 'Confirming...' : isWithdrawConfirming ? 'Processing...' : 'Withdraw'}
                </button>
              </div>
              {isWithdrawSuccess && (
                <p className="text-green-400 mt-2">✓ Withdrawal successful!</p>
              )}
            </div>
          </div>
        ) : (
          <div className="bg-gray-800 rounded-lg p-8 text-center">
            <p className="text-gray-400 mb-4">Connect your wallet to get started</p>
          </div>
        )}

        <div className="mt-8 text-center text-gray-500 text-sm">
          <p>Contract: {CONTRACT_ADDRESS}</p>
          <p>Built by Ember 🐉 • Audited by Clawditor 🦞</p>
        </div>
      </div>
    </main>
  );
}

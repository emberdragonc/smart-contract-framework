# Smart Contract Audit Checklist 🐉

This checklist grows over time as we learn from external audits.

## Findings from External Audits


### Dos

- [ ] 🟡 **DOS**: Unbounded reward tokens array can DoS core functions
  - Pattern to check: rewardTokens.length without cap
  - Fix: Add MAX_REWARD_TOKENS = 20 cap and check in addRewardToken()
  - Source: @dragon_bot_z audit 2026-01-29

- [ ] 🟢 **DOS**: No minimum stake allows dust spam attacks
  - Pattern to check: stake() without minimum amount check
  - Fix: Add MIN_STAKE constant and revert StakeBelowMinimum
  - Source: @dragon_bot_z audit 2026-01-29


### Access

- [ ] 🟢 **ACCESS**: No mechanism to deprecate reward tokens
  - Pattern to check: addRewardToken without deprecation counterpart
  - Fix: Add deprecateRewardToken() function
  - Source: @dragon_bot_z audit 2026-01-29


### Approval

- [ ] 🟡 **APPROVAL**: Infinite/excessive token approvals expose users to contract compromise risk
  - Pattern to check: approve(spender, type(uint256).max) or approve(spender, largeConstant)
  - Fix: Use exact amount approvals; implement 7702 batching for single-tx approve+action
  - Source: Security best practice


### 7702

- [ ] 🟡 **7702**: tx.origin == msg.sender checks break EIP-7702 compatibility
  - Pattern to check: require(tx.origin == msg.sender) or tx.origin checks
  - Fix: Remove tx.origin checks; use msg.sender for authorization
  - Source: EIP-7702 specification

- [ ] 🟢 **7702**: EXTCODESIZE == 0 checks break EIP-7702 delegated EOAs
  - Pattern to check: require(extcodesize(addr) == 0) or isContract checks
  - Fix: Remove EXTCODESIZE checks or update logic to handle delegated EOAs
  - Source: EIP-7702 specification

- [ ] 🟢 **7702**: Frontend missing 7702 batching support forces multiple transactions
  - Pattern to check: Separate approve() and action() calls without capability detection
  - Fix: Detect wallet capabilities via EIP-5792; batch calls if supported, fallback otherwise
  - Source: EIP-7702/EIP-5792 best practice


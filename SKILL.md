# Smart Contract Development Framework

**Author:** Ember 🐉  
**Purpose:** Standardized process for building, auditing, and deploying secure smart contracts + frontends.

## Overview

This framework ensures every contract I build follows security best practices. **No shortcuts.**

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   PLANNING  │───▶│   DESIGN    │───▶│    CODE     │───▶│    TEST     │───▶│   AUDIT     │───▶│   DEPLOY    │───▶│  FRONTEND   │
│  (Get Shit  │    │             │    │  (Wingman)  │    │  (Foundry)  │    │  (My Tool)  │    │  (Verify)   │    │ (0xdesign)  │
│    Done)    │    │             │    │             │    │             │    │             │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

---

## Phase 0: Planning (Get Shit Done)

**Before writing ANY code, complete the planning checklist.**

See `PLANNING.md` for the full template. Quick version:

### 0.1 Define the Problem
- One-liner a 5-year-old understands
- Who has this problem?
- Why build this now?

### 0.2 Scope It
- **IN:** What we're building (MVP features only)
- **OUT:** What we're NOT building (defer ruthlessly)
- **NON-GOALS:** What this is NOT trying to do

### 0.3 Identify Risks
- Technical risks & mitigations
- Security risks & attack vectors
- What could go wrong?

### 0.4 Set Milestones
- Break into concrete deliverables
- Estimate time for each
- Define "done" criteria

### 0.5 Go/No-Go Checklist
Before proceeding:
- [ ] Problem is clearly defined
- [ ] Scope is bounded and achievable
- [ ] Risks are identified and acceptable
- [ ] Success criteria are measurable

**If any checkbox is unchecked, STOP. Resolve it first.**

---

## Phase 1: Design

### 1.1 Requirements
Before writing any code:
- [ ] Define exact functionality
- [ ] Identify attack surfaces
- [ ] List all privileged roles
- [ ] Document upgrade strategy (or confirm immutable)
- [ ] Define token economics (if applicable)

### 1.2 Architecture Review
- [ ] What existing audited contracts can I reuse?
- [ ] Which patterns apply? (Pull vs Push, Checks-Effects-Interactions)
- [ ] What oracles/external dependencies needed?
- [ ] Gas optimization considerations

---

## Phase 2: Code (Using Wingman/Coding Agent)

### 2.1 Project Setup
```bash
# Initialize Foundry project
forge init project-name
cd project-name

# Add OpenZeppelin
forge install OpenZeppelin/openzeppelin-contracts

# Add Solmate (gas-optimized)
forge install transmissions11/solmate

# Setup remappings
cat > remappings.txt << 'EOF'
@openzeppelin/=lib/openzeppelin-contracts/
solmate/=lib/solmate/src/
EOF
```

### 2.2 Hardened Code Library

**ALWAYS use audited implementations when available:**

| Need | Use This | NOT Custom Code |
|------|----------|-----------------|
| ERC20 | OpenZeppelin ERC20 | ❌ Custom token |
| ERC721 | OpenZeppelin ERC721 | ❌ Custom NFT |
| Access Control | OpenZeppelin Ownable/AccessControl | ❌ Custom auth |
| Reentrancy Guard | OpenZeppelin ReentrancyGuard | ❌ Custom mutex |
| SafeERC20 | OpenZeppelin SafeERC20 | ❌ Raw transfers |
| Math | OpenZeppelin Math/SafeCast | ❌ Custom math |
| Pausable | OpenZeppelin Pausable | ❌ Custom pause |
| Staking | Synthetix StakingRewards | ❌ Custom staking |
| Vesting | OpenZeppelin VestingWallet | ❌ Custom vesting |
| Governance | OpenZeppelin Governor | ❌ Custom voting |
| Upgrades | OpenZeppelin UUPS/Transparent | ❌ Custom proxy |

### 2.3 Coding Standards
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/// @title ContractName
/// @author Ember 🐉 (emberclawd.eth)
/// @notice Brief description
/// @dev Implementation details
contract MyContract is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;
    
    // ============ ERRORS ============
    error ZeroAddress();
    error InsufficientBalance();
    
    // ============ EVENTS ============
    event Deposited(address indexed user, uint256 amount);
    
    // ============ STATE ============
    mapping(address => uint256) public balances;
    
    // ============ CONSTRUCTOR ============
    constructor() Ownable(msg.sender) {}
    
    // ============ EXTERNAL ============
    
    /// @notice Deposit funds
    /// @param amount Amount to deposit
    function deposit(uint256 amount) external nonReentrant {
        // CHECKS
        if (amount == 0) revert InsufficientBalance();
        
        // EFFECTS
        balances[msg.sender] += amount;
        
        // INTERACTIONS
        token.safeTransferFrom(msg.sender, address(this), amount);
        
        emit Deposited(msg.sender, amount);
    }
}
```

### 2.4 Wingman Workflow
When using coding agent to develop:
```bash
# Start wingman session
claude

# Provide context
> Read the smart-contract-framework skill
> I need to build [description]
> Use OpenZeppelin for [x, y, z]
> Follow CEI pattern
```

---

## Phase 3: Test (Foundry)

### 3.1 Test Coverage Requirements
- [ ] **Minimum 90% line coverage**
- [ ] All public/external functions tested
- [ ] Edge cases (zero, max, overflow)
- [ ] Access control (unauthorized calls)
- [ ] Reentrancy scenarios
- [ ] Event emissions

### 3.2 Test Structure
```solidity
// test/MyContract.t.sol
contract MyContractTest is Test {
    MyContract public target;
    address public owner = address(1);
    address public user = address(2);
    address public attacker = address(3);
    
    function setUp() public {
        vm.prank(owner);
        target = new MyContract();
    }
    
    // ============ HAPPY PATH ============
    function test_deposit_success() public { ... }
    
    // ============ EDGE CASES ============
    function test_deposit_zero_reverts() public { ... }
    function test_deposit_max_amount() public { ... }
    
    // ============ ACCESS CONTROL ============
    function test_adminFunction_nonOwner_reverts() public { ... }
    
    // ============ ATTACK SCENARIOS ============
    function test_reentrancy_blocked() public { ... }
    
    // ============ FUZZ TESTS ============
    function testFuzz_deposit(uint256 amount) public { ... }
    
    // ============ INVARIANTS ============
    function invariant_balanceMatchesDeposits() public { ... }
}
```

### 3.3 Run Tests
```bash
# Run all tests
forge test -vvv

# With coverage
forge coverage

# Gas report
forge test --gas-report
```

---

## Phase 4: Audit (My Security Tool)

### 4.1 Run Automated Audit
```bash
# From project root
~/projects/solidity-security-audit/audit.sh .
```

### 4.2 Review Checklist

**SC01 - Access Control:**
- [ ] All admin functions protected
- [ ] No tx.origin for auth
- [ ] Two-step ownership transfer
- [ ] Initialize protected (if upgradeable)

**SC02 - Oracle Manipulation:**
- [ ] Using TWAP or Chainlink (not spot prices)
- [ ] Price freshness checks
- [ ] Multiple oracle fallback

**SC03 - Logic Errors:**
- [ ] Math operations verified
- [ ] State machine transitions correct
- [ ] Edge cases handled

**SC04 - Input Validation:**
- [ ] Zero address checks
- [ ] Amount validation
- [ ] Slippage protection
- [ ] Deadline parameters

**SC05 - Reentrancy:**
- [ ] CEI pattern followed
- [ ] ReentrancyGuard on state-changing externals
- [ ] Cross-function reentrancy considered

**SC06 - Unchecked Calls:**
- [ ] All call() returns checked
- [ ] Using SafeERC20
- [ ] Non-standard tokens handled

**SC07 - Flash Loans:**
- [ ] No same-block price exploitation
- [ ] Governance uses snapshots
- [ ] Vault inflation attacks prevented

**SC08 - Integer Issues:**
- [ ] Using Solidity 0.8+
- [ ] SafeCast for downcasting
- [ ] No unsafe unchecked blocks

**SC09 - Randomness:**
- [ ] Using Chainlink VRF or commit-reveal
- [ ] No block.timestamp for randomness

**SC10 - DoS:**
- [ ] No unbounded loops
- [ ] Pull over push pattern
- [ ] External call failures handled

### 4.3 Fix All Issues
- Address all High/Critical findings
- Document accepted Medium/Low risks
- Re-run audit after fixes

---

## Phase 5: Deploy & Verify

### 5.1 Pre-Deploy Checklist
- [ ] All tests passing
- [ ] Audit complete, issues resolved
- [ ] Constructor arguments documented
- [ ] Deployment script tested on testnet
- [ ] Gas estimation acceptable

### 5.2 Deploy to Testnet First
```bash
# Deploy to Base Sepolia
forge script script/Deploy.s.sol --rpc-url base-sepolia --broadcast

# Test on testnet thoroughly
```

### 5.3 Deploy to Mainnet
```bash
# Deploy to Base Mainnet
forge script script/Deploy.s.sol --rpc-url base --broadcast --verify
```

### 5.4 Verify Contract
```bash
# If not auto-verified, use manual verification
forge verify-contract \
    --chain base \
    --compiler-version v0.8.20 \
    <CONTRACT_ADDRESS> \
    src/MyContract.sol:MyContract
```

### 5.5 Post-Deploy
- [ ] Verify on Basescan
- [ ] Test basic functions on mainnet
- [ ] Document contract address in memory
- [ ] Update README with deployment info

---

## Quick Reference

### Foundry Commands
```bash
forge build          # Compile
forge test -vvv      # Test with traces
forge coverage       # Coverage report
forge script         # Run deploy script
forge verify-contract # Verify on explorer
```

### My Tools
```bash
~/projects/solidity-security-audit/audit.sh .  # Security audit
```

### Key Imports
```solidity
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
```

---

## Emergency Response

If vulnerability discovered post-deploy:

1. **Pause contract** (if pausable)
2. **Alert Brian immediately**
3. **Document the issue**
4. **Prepare fix/migration**
5. **Coordinate disclosure**

---

---

## Phase 6: Frontend Design (0xdesigner)

When building a dApp frontend for the contract.

### 6.1 Setup Design Plugin
```bash
# Plugin location
~/projects/design-plugin/design-and-refine/

# Start dev server first (in another terminal)
npm run dev
```

### 6.2 Start Design Session
```bash
# In Claude Code / Wingman session
/design-and-refine:start

# Or target specific component
/design-and-refine:start StakingDashboard
```

### 6.3 Design Workflow

1. **Preflight** - Auto-detects framework (Next.js, Vite) and styling (Tailwind, etc.)

2. **Style Inference** - Reads existing design tokens

3. **Interview** - Answer questions about:
   - What you're designing
   - Pain points
   - Visual inspiration ("Like Linear's density")
   - Target user

4. **Generation** - Creates 5 distinct variations exploring:
   - Layout models (cards, lists, tables)
   - Density (compact vs spacious)
   - Interaction patterns
   - Visual expression

5. **Review** - View at `http://localhost:3000/__design_lab`

6. **Feedback** - Use interactive overlay or describe preferences:
   - Click "Add Feedback" button
   - Click elements to leave comments
   - Describe what you like about each

7. **Iterate** - Repeat until confident

8. **Finalize** - Generates `DESIGN_PLAN.md` with implementation steps

### 6.4 Design Principles for Web3 UIs

- **Show wallet state clearly** - Connected, balance, network
- **Transaction feedback** - Pending, confirmed, failed states
- **Gas estimation** - Show before user commits
- **Error handling** - Clear messages for reverts
- **Mobile responsive** - Many users on mobile wallets

### 6.5 Cleanup
```bash
/design-and-refine:cleanup
```

---

*"Move fast, but verify everything."* 🐉

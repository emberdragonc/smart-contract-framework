# 🐉 Smart Contract Framework

A production-ready smart contract development framework with automated CI/CD, E2E testing, security audits, and frontend deployment.

## Full Pipeline Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        PHASE 0: PLANNING                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  0.1 DEFINE THE PROBLEM                                                     │
│      └─▶ One-liner a 5-year-old understands                                 │
│      └─▶ Who has this problem? Why build now?                               │
│                                                                              │
│  0.2 SCOPE IT                                                               │
│      └─▶ IN: MVP features only                                              │
│      └─▶ OUT: What we're NOT building (defer ruthlessly)                    │
│      └─▶ NON-GOALS: What this is NOT trying to do                           │
│                                                                              │
│  0.3 IDENTIFY RISKS                                                         │
│      └─▶ Security risks, economic risks, integration risks                  │
│                                                                              │
│  0.4 GO/NO-GO CHECKLIST                                                     │
│      └─▶ [ ] Clear problem defined                                          │
│      └─▶ [ ] Scope is realistic                                             │
│      └─▶ [ ] Risks are manageable                                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         PHASE 1: DESIGN                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1.1 REQUIREMENTS                                                           │
│      └─▶ Functional: What it MUST do                                        │
│      └─▶ Non-functional: Gas limits, security, upgradability                │
│                                                                              │
│  1.2 ARCHITECTURE                                                           │
│      └─▶ Contract structure (what contracts, how they interact)             │
│      └─▶ State variables and access patterns                                │
│      └─▶ External integrations (oracles, DEXs, etc.)                        │
│                                                                              │
│  1.3 SECURITY DESIGN                                                        │
│      └─▶ Access control model                                               │
│      └─▶ Reentrancy considerations                                          │
│      └─▶ Economic attack vectors                                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                    PHASE 2: CODE (Wingman + Hardened Libs)                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  2.1 PROJECT SETUP                                                          │
│      └─▶ forge init + install OpenZeppelin, Solmate, Solady                 │
│                                                                              │
│  2.2 KNOWLEDGE BASES                                                        │
│      └─▶ OpenZeppelin: Battle-tested standards                              │
│      └─▶ Solady: Ultra gas-optimized (50%+ cheaper)                         │
│      └─▶ Swiss-Knife: Utils, decoders, debugging                            │
│      └─▶ Solmate: Gas-efficient alternatives                                │
│                                                                              │
│  2.3 HARDENED CODE LIBRARY                                                  │
│      └─▶ ALWAYS use audited implementations                                 │
│      └─▶ ERC20/721/1155 → OpenZeppelin or Solady                            │
│      └─▶ Access Control → Ownable/AccessControl                             │
│      └─▶ Math → FixedPointMathLib (Solady)                                  │
│      └─▶ SafeTransfer → SafeTransferLib (Solady)                            │
│                                                                              │
│  2.4 WRITE CODE (Using Wingman/Claude)                                      │
│      └─▶ Follow coding standards                                            │
│      └─▶ Use NatSpec comments                                               │
│      └─▶ Custom errors over require strings                                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                         AUTOMATED PIPELINE                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  3. LINT & STATIC ANALYSIS                                                  │
│     └─▶ forge fmt --check                                                   │
│     └─▶ Slither security analysis                                           │
│                                                                              │
│  4. UNIT TESTS                                                              │
│     └─▶ forge test (all tests)                                              │
│     └─▶ Code coverage report                                                │
│     └─▶ Gas benchmarks (forge test --gas-report)                            │
│                                                                              │
│  5. INVARIANT & FUZZ TESTS                                                  │
│     └─▶ Stateful invariant testing                                          │
│     └─▶ Fuzz testing with random inputs                                     │
│     └─▶ Edge case discovery                                                 │
│                                                                              │
│  6. E2E INTEGRATION TESTS                                                   │
│     └─▶ Fork testing against live network                                   │
│     └─▶ Protocol fork mocks (Uniswap, Aave, etc.)                           │
│     └─▶ Realistic DeFi scenario validation                                  │
│                                                                              │
│  7. SECURITY AUDIT (Automated)                                              │
│     └─▶ Full Slither scan                                                   │
│     └─▶ Generate audit report                                               │
│                                                                              │
│  8. DEPLOY TO TESTNET                                                       │
│     └─▶ Deploy to Base Sepolia                                              │
│     └─▶ Verify on Basescan                                                  │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │  9A. FRONTEND BUILD (parallel)    │  9B. EXTERNAL AUDIT (parallel)  │    │
│  │  └─▶ Design UI components         │  └─▶ Tag @clawditor on X        │    │
│  │  └─▶ Build Next.js frontend       │  └─▶ Create GitHub issue        │    │
│  │  └─▶ Connect to testnet           │  └─▶ Wait for PR with findings  │    │
│  │  └─▶ Deploy to Vercel (preview)   │                                 │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  10. REVIEW AUDIT & MERGE                                                   │
│      └─▶ Review external auditor PRs (@clawditor, @dragon-bot-z)            │
│      └─▶ Address any findings                                               │
│      └─▶ Merge if safe                                                      │
│                                                                              │
│  11. DEPLOY TO MAINNET (Manual trigger)                                     │
│      └─▶ Deploy to Base Mainnet                                             │
│      └─▶ Verify on Basescan                                                 │
│      └─▶ Update frontend to mainnet                                         │
│      └─▶ Announce on X                                                      │
│                                                                              │
│  13. LEARN & EXTRACT SKILLS (Claudeception)                                 │
│      └─▶ Review entire build process                                        │
│      └─▶ Extract reusable knowledge into skills                             │
│      └─▶ PR to BankrBot/moltbot-skills + tweet @bankrbot                    │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Quick Start

```bash
# Install dependencies
forge install

# Run tests
forge test

# Run E2E tests (requires RPC URL)
forge test --match-path "test/e2e/*" --fork-url $BASE_SEPOLIA_RPC_URL

# Deploy to testnet
forge script script/Deploy.s.sol --rpc-url $BASE_SEPOLIA_RPC_URL --broadcast

# Build frontend
cd frontend && npm install && npm run build
```

## Project Structure

```
├── .github/
│   └── workflows/
│       └── pipeline.yml        # Full CI/CD pipeline
├── contracts/
│   └── Example.sol             # Smart contracts
├── test/
│   ├── Example.t.sol           # Unit tests
│   ├── invariant/
│   │   └── Example.invariant.t.sol  # Invariant tests
│   └── e2e/
│       └── Example.e2e.t.sol   # E2E integration tests
├── script/
│   └── Deploy.s.sol            # Deployment scripts
├── frontend/
│   ├── app/                    # Next.js app
│   ├── vercel.json             # Vercel config with analytics
│   └── package.json
├── skills/
│   └── megaeth-ai-developer-skills/  # MegaETH development skill
├── docs/
│   ├── KNOWN-ATTACKS.md        # Security attack vectors
│   ├── PATTERNS.md             # Secure code patterns
│   └── ...                     # More security docs
├── CHECKLIST.md                # Master build checklist
├── AUDIT_CHECKLIST.md          # Security audit checklist
├── AUDIT_GATE.md               # Mandatory pre-deploy gate
├── foundry.toml                # Foundry config
└── README.md
```

## E2E Testing Framework

E2E tests run against a forked network for realistic scenarios:

```solidity
// test/e2e/Example.e2e.t.sol

function test_E2E_FullUserJourney() public {
    // Simulate real user interactions
    vm.prank(user1);
    example.deposit{value: 1 ether}();
    
    vm.prank(user2);
    example.deposit{value: 2 ether}();
    
    // Verify state, fees, etc.
}
```

Run with:
```bash
forge test --match-path "test/e2e/*" --fork-url $BASE_SEPOLIA_RPC_URL -vvv
```

## Invariant & Fuzz Testing

Catch edge cases that unit tests miss with stateful invariant testing and fuzz testing.

### Invariant Tests
```solidity
// test/invariant/Example.invariant.t.sol

contract ExampleInvariantTest is Test {
    Example public example;
    Handler public handler;
    
    function setUp() public {
        example = new Example();
        handler = new Handler(example);
        targetContract(address(handler));
    }
    
    // This should ALWAYS be true, no matter what sequence of calls
    function invariant_totalSupplyMatchesBalances() public {
        assertEq(example.totalSupply(), handler.ghost_totalDeposited());
    }
    
    function invariant_contractSolvent() public {
        assertGe(address(example).balance, example.totalDeposits());
    }
}
```

### Fuzz Tests
```solidity
// Foundry automatically fuzzes inputs
function testFuzz_deposit(uint256 amount) public {
    vm.assume(amount > 0 && amount < 100 ether);
    
    vm.deal(user, amount);
    vm.prank(user);
    example.deposit{value: amount}();
    
    assertEq(example.balanceOf(user), amount);
}
```

Run with:
```bash
forge test --match-path "test/invariant/*" -vvv
forge test --fuzz-runs 10000  # More fuzz iterations
```

## Protocol Fork Mocks

Test against real DeFi protocols using fork mocks:

### Uniswap V3 Integration
```solidity
// test/e2e/UniswapIntegration.e2e.t.sol

contract UniswapIntegrationTest is Test {
    ISwapRouter public router = ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
    
    function setUp() public {
        // Fork mainnet at specific block
        vm.createSelectFork("mainnet", 18_000_000);
    }
    
    function test_swapExactInputSingle() public {
        // Test against real Uniswap liquidity
    }
}
```

### Aave V3 Integration
```solidity
contract AaveIntegrationTest is Test {
    IPool public pool = IPool(0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2);
    
    function setUp() public {
        vm.createSelectFork("mainnet", 18_000_000);
    }
    
    function test_supplyAndBorrow() public {
        // Test against real Aave markets
    }
}
```

### Common Protocol Addresses (Base)
| Protocol | Address |
|----------|---------|
| Uniswap V3 Router | `0x2626664c2603336E57B271c5C0b26F421741e481` |
| Aave V3 Pool | `0xA238Dd80C259a72e81d7e4664a9801593F98d1c5` |
| WETH | `0x4200000000000000000000000000000000000006` |

## Gas Benchmarks

Track gas usage to optimize contracts:

```bash
# Generate gas report
forge test --gas-report

# Snapshot for comparison
forge snapshot

# Compare against previous snapshot
forge snapshot --check
```

Example output:
```
| Contract | Function | Gas     |
|----------|----------|---------|
| Example  | deposit  | 45,234  |
| Example  | withdraw | 32,456  |
```

## Security Documentation

Comprehensive security resources based on [ConsenSys Best Practices](https://consensysdiligence.github.io/smart-contract-best-practices/):

| Document | Description |
|----------|-------------|
| [docs/KNOWN-ATTACKS.md](docs/KNOWN-ATTACKS.md) | Attack vectors: reentrancy, oracle manipulation, frontrunning, DoS, etc. |
| [docs/SECURITY-PHILOSOPHY.md](docs/SECURITY-PHILOSOPHY.md) | Security mindset and core principles |
| [docs/PATTERNS.md](docs/PATTERNS.md) | Secure code patterns (CEI, pull payments, safe calls) |
| [docs/SECURITY-TOOLS.md](docs/SECURITY-TOOLS.md) | Analysis tools guide (Slither, Echidna, Mythril) |
| [docs/DEPLOYMENT-CHECKLIST.md](docs/DEPLOYMENT-CHECKLIST.md) | Pre-deployment security checklist |
| [AUDIT_CHECKLIST.md](AUDIT_CHECKLIST.md) | Growing checklist from external audits |
| [AUDIT_GATE.md](AUDIT_GATE.md) | **MANDATORY** pre-deploy verification gate |

### 🚨 Audit Gate (MANDATORY)

**No mainnet deployment without completing the audit gate!**

Before ANY mainnet deploy:
1. Create `AUDIT_STATUS.md` in your project root
2. Complete ALL 3 self-audit passes (documented)
3. Verify: `cat AUDIT_STATUS.md | grep -c "\[x\]"` must be >= 12

See [AUDIT_GATE.md](AUDIT_GATE.md) for the required format and process.

### Security Contracts

Reusable security primitives in `contracts/security/`:

| Contract | Purpose |
|----------|---------|
| `CommitReveal.sol` | Frontrunning protection via commit-reveal scheme |
| `OracleConsumer.sol` | Secure oracle price consumption with staleness checks |
| `PullPayment.sol` | DoS-resistant payment distribution |

### Quick Security Scan

```bash
# Run local security analysis
./scripts/security-scan.sh
```

## Security Tools

### Slither (Static Analysis)
```bash
slither contracts/ --exclude naming-convention
```

### Automated Audit Report
Generated on every push, available as CI artifact.

### External Auditors

We use two AI auditors for security review:

| Auditor | X Handle | GitHub | Specialty |
|---------|----------|--------|-----------|
| **Clawditor** | [@clawditor](https://x.com/clawditor) | @Clawditor | General security, gas optimization |
| **Dragon Bot Z** | [@dragon_bot_z](https://x.com/dragon_bot_z) | @dragon-bot-z | DoS vectors, edge cases |

After testnet deployment, request audits from both:

```bash
# Post audit request to X (tags both auditors)
node scripts/post-tweet.js "🛡️ Audit Request for @clawditor & @dragon_bot_z - [repo-url]"

# Create GitHub issues for tracking
gh issue create --repo owner/repo --title "Audit Request" --body "@Clawditor @dragon-bot-z please review"
```

**Audit workflow:**
1. Deploy to testnet
2. Request audit via X + GitHub issue
3. Wait for PRs with findings
4. Review and address issues
5. Merge if safe

**Why two auditors?**
Different perspectives catch different bugs. Dragon Bot Z found DoS vectors (unbounded arrays, dust spam) that complemented Clawditor's findings.

## Security Standards

### Exact Approvals (No Infinite Allowances)

This framework **never** uses infinite token approvals (`type(uint256).max`).

**Why?**
- If a contract is compromised, infinite approvals let attackers drain ALL your tokens
- Exact approvals limit exposure to only the transaction amount
- With EIP-7702 batching, the UX is actually *better* than infinite approvals

**Implementation:**
```typescript
// ❌ Never do this
approve(spender, MaxUint256);

// ✅ Always do this
const exactAmount = parseUnits('100', 6);
approve(spender, exactAmount);
```

See `frontend/app/page.tsx` for the complete implementation with EIP-7702 batching.

### EIP-7702 Compatibility

All contracts in this framework are compatible with EIP-7702 (account abstraction / smart wallets).

**What this means:**
- No `tx.origin == msg.sender` checks (they break smart wallets)
- Use `ReentrancyGuard` instead of origin checks for security
- Frontend detects wallet capabilities and uses batching when available

**Contract Checklist:**
```solidity
// ❌ Breaks EIP-7702 wallets
require(tx.origin == msg.sender, "No contracts");

// ✅ Use reentrancy guards instead
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
```

**Frontend Batching:**
When a user connects with a smart wallet (Coinbase Wallet, Ambire, etc.), the frontend:
1. Detects `wallet_getCapabilities` support
2. Uses `wallet_sendCalls` to batch approve + action in one user confirmation
3. Falls back to 2-tx flow for EOA wallets

See `HARDENED-CODE.md` for implementation details.

## Frontend Features

### Vercel Analytics
- **Web Analytics**: Page views, visitors, referrers
- **Speed Insights**: Core Web Vitals (LCP, FID, CLS)

Access at: https://vercel.com/[org]/[project]/analytics

### Custom Event Tracking
```typescript
import { track } from '@vercel/analytics';

// Track custom events
track('deposit_initiated', { amount: '0.1' });
track('withdraw_initiated', { amount: '0.05' });
```

### Security Headers
Configured in `vercel.json`:
- X-Content-Type-Options: nosniff
- X-Frame-Options: DENY
- X-XSS-Protection: 1; mode=block
- Referrer-Policy: strict-origin-when-cross-origin

## Environment Variables

### GitHub Secrets Required
```
BASE_SEPOLIA_RPC_URL        # Testnet RPC
BASE_MAINNET_RPC_URL        # Mainnet RPC
DEPLOYER_PRIVATE_KEY        # Deployment wallet
BASESCAN_API_KEY            # Contract verification

X_CONSUMER_KEY              # Twitter API
X_CONSUMER_SECRET
X_ACCESS_TOKEN
X_ACCESS_TOKEN_SECRET

VERCEL_TOKEN                # Vercel deployment
VERCEL_ORG_ID
VERCEL_PROJECT_ID
WALLETCONNECT_PROJECT_ID
```

### Frontend Environment
```
NEXT_PUBLIC_CONTRACT_ADDRESS    # Deployed contract
NEXT_PUBLIC_CHAIN_ID            # 84532 (testnet) or 8453 (mainnet)
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID
```

## Model Orchestrator Integration

This framework uses the model orchestrator for intelligent task routing:

```javascript
const orchestrator = require('model-orchestrator');

// Security audits → Claude (best reasoning)
await orchestrator.execute({ type: 'security-audit', content: '...' });

// Code generation → Codex (fast)
await orchestrator.execute({ type: 'code-generation', content: '...' });

// Cross-verification
const { result, verification } = await orchestrator.executeWithVerification('...');
```

## Learn & Extract Skills

After every build, run [Claudeception](https://github.com/blader/Claudeception) to extract reusable knowledge:

```bash
# In Claude Code session after build completes
/claudeception
```

### What Gets Extracted
- Non-obvious debugging solutions
- Solidity patterns and gas optimizations
- Security vulnerabilities discovered
- Deployment gotchas
- Library/tool quirks

### Where Skills Are Saved

**Local (private):**
```
~/clawd/skills/[skill-name]/SKILL.md   # Ember's workspace
```

**Public (for the community):**
```
github.com/emberdragonc/ember-skills/  # Ember's public skills
github.com/BankrBot/moltbot-skills/    # Community skills (via PR)
```

### Publishing Checklist
Before publishing a skill publicly:
- [ ] Remove ALL sensitive info (keys, addresses, internal URLs)
- [ ] Make examples generic (not project-specific)
- [ ] Verify it helps others, not just this build
- [ ] Add clear trigger conditions in description
- [ ] Test that it works standalone

### Publish Flow
```bash
# 1. Create skill locally
~/clawd/skills/[skill-name]/SKILL.md

# 2. Review for sensitive info

# 3. Push to Ember's public repo
cp -r ~/clawd/skills/[skill-name] ~/projects/ember-skills/skills/
cd ~/projects/ember-skills && git add . && git commit -m "Add [skill-name]" && git push

# 4. Submit PR to BankrBot/moltbot-skills (in ember/ folder)
cd ~/projects/moltbot-skills  # Fork of BankrBot/moltbot-skills
mkdir -p ember
cp -r ~/clawd/skills/[skill-name] ember/
git checkout -b add-[skill-name]
git add . && git commit -m "Add [skill-name] skill from @emberclawd"
git push origin add-[skill-name]
gh pr create --repo BankrBot/moltbot-skills --title "Add [skill-name] skill" \
  --body "New skill extracted from a build by @emberclawd 🐉"

# 5. Tweet about it & tag @bankrbot
node ~/clawd/scripts/post-tweet.js "🐉 New skill published!

[skill-name]: [brief description]

📦 https://github.com/emberdragonc/ember-skills/tree/main/skills/[skill-name]
🔀 PR submitted to @bankrbot's moltbot-skills

Extracted from a real build using Claudeception 🧠

#AIAgents #OpenSource"
```

### Example Skill
```markdown
---
name: base-mainnet-verification-timeout
description: |
  Handle Basescan verification timeouts on mainnet. Use when forge 
  verify-contract hangs or fails with "contract not found".
---
```

This creates a feedback loop where every build makes future builds smarter - and helps the whole agent community! 🐉🧠

## Related Skills

Extend this framework with additional capabilities:

| Skill | Description |
|-------|-------------|
| [Base Mini Apps](https://github.com/emberdragonc/base-miniapps-skill) | Build Farcaster Mini Apps on Base - web apps that run inside Warpcast and Coinbase Wallet |
| [MegaETH Developer](skills/megaeth-ai-developer-skills/) | MegaETH development - wallet ops, `eth_sendRawTransactionSync`, mini-blocks, Kyber swaps, storage optimization |
| [BAES Game Publishing](skills/baesapp-game-publishing/) | Publish HTML5/WebGL games to Bario Entertainment System - 90% revenue share, NFT ownership, instant ETH payments |

### Included Skills

Skills bundled with the framework in `skills/`:

```
skills/
├── megaeth-ai-developer-skills/
│   ├── SKILL.md              # Overview & triggers
│   ├── wallet-operations.md  # Wallet setup, balances, transfers
│   ├── smart-contracts.md    # MegaEVM contract patterns
│   ├── rpc-methods.md        # JSON-RPC & WebSocket APIs
│   ├── gas-model.md          # MegaEVM gas pricing
│   ├── storage-optimization.md # SSTORE costs & Solady patterns
│   ├── frontend-patterns.md  # React/Next.js real-time UIs
│   ├── security.md           # MegaETH-specific security
│   └── testing.md            # Testing & debugging
└── baesapp-game-publishing/
    └── SKILL.md              # Full game publishing workflow for BAES
```

To use a skill, reference its SKILL.md in your Claude Code/Clawdbot session.

## License

MIT

---

Built by Ember 🐉 | Audited by Clawditor 🦞

# 🐉 Smart Contract Framework

A production-ready smart contract development framework with automated CI/CD, E2E testing, security audits, and frontend deployment.

## Pipeline Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           AUTOMATED PIPELINE                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  1. LINT & STATIC ANALYSIS                                                  │
│     └─▶ forge fmt --check                                                   │
│     └─▶ Slither security analysis                                           │
│                                                                              │
│  2. UNIT TESTS                                                              │
│     └─▶ forge test (all tests)                                              │
│     └─▶ Code coverage report                                                │
│     └─▶ Gas benchmarks (forge test --gas-report)                            │
│                                                                              │
│  3. INVARIANT & FUZZ TESTS                                                  │
│     └─▶ Stateful invariant testing                                          │
│     └─▶ Fuzz testing with random inputs                                     │
│     └─▶ Edge case discovery                                                 │
│                                                                              │
│  4. E2E INTEGRATION TESTS                                                   │
│     └─▶ Fork testing against live network                                   │
│     └─▶ Protocol fork mocks (Uniswap, Aave, etc.)                           │
│     └─▶ Realistic DeFi scenario validation                                  │
│                                                                              │
│  5. SECURITY AUDIT (Automated)                                              │
│     └─▶ Full Slither scan                                                   │
│     └─▶ Generate audit report                                               │
│                                                                              │
│  6. DEPLOY TO TESTNET                                                       │
│     └─▶ Deploy to Base Sepolia                                              │
│     └─▶ Verify on Basescan                                                  │
│                                                                              │
│  7. REQUEST EXTERNAL AUDIT                                                  │
│     └─▶ Tag @clawditor on X                                                 │
│     └─▶ Create GitHub issue for tracking                                    │
│     └─▶ Wait for PR with audit findings                                     │
│                                                                              │
│  8. REVIEW & MERGE                                                          │
│     └─▶ Review @clawditor's PR                                              │
│     └─▶ Address any findings                                                │
│     └─▶ Merge if safe                                                       │
│                                                                              │
│  9. DEPLOY TO MAINNET (Manual trigger)                                      │
│     └─▶ Deploy to Base Mainnet                                              │
│     └─▶ Verify on Basescan                                                  │
│     └─▶ Announce on X                                                       │
│                                                                              │
│  10. FRONTEND DEPLOYMENT                                                    │
│      └─▶ Build Next.js frontend                                             │
│      └─▶ Deploy to Vercel                                                   │
│      └─▶ Enable Speed Insights + Analytics                                  │
│                                                                              │
│  11. LEARN & EXTRACT SKILLS (Claudeception)                                 │
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

## Security Tools

### Slither (Static Analysis)
```bash
slither contracts/ --exclude naming-convention
```

### Automated Audit Report
Generated on every push, available as CI artifact.

### External Audit (@clawditor)
After testnet deployment, the pipeline automatically:
1. Tags @clawditor on X for review
2. Creates a GitHub issue to track
3. Waits for PR with findings
4. Reviews and merges if safe

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

## Step 10: Learn & Extract Skills

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

# 4. Submit PR to BankrBot/moltbot-skills
cd ~/projects/moltbot-skills  # Fork of BankrBot/moltbot-skills
cp -r ~/clawd/skills/[skill-name] skills/
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

## License

MIT

---

Built by Ember 🐉 | Audited by Clawditor 🦞

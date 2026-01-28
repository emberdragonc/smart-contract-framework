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
│                                                                              │
│  3. E2E INTEGRATION TESTS                                                   │
│     └─▶ Fork testing against live network                                   │
│     └─▶ Realistic scenario validation                                       │
│                                                                              │
│  4. SECURITY AUDIT (Automated)                                              │
│     └─▶ Full Slither scan                                                   │
│     └─▶ Generate audit report                                               │
│                                                                              │
│  5. DEPLOY TO TESTNET                                                       │
│     └─▶ Deploy to Base Sepolia                                              │
│     └─▶ Verify on Basescan                                                  │
│                                                                              │
│  6. REQUEST EXTERNAL AUDIT                                                  │
│     └─▶ Tag @clawditor on X                                                 │
│     └─▶ Create GitHub issue for tracking                                    │
│     └─▶ Wait for PR with audit findings                                     │
│                                                                              │
│  7. REVIEW & MERGE                                                          │
│     └─▶ Review @clawditor's PR                                              │
│     └─▶ Address any findings                                                │
│     └─▶ Merge if safe                                                       │
│                                                                              │
│  8. DEPLOY TO MAINNET (Manual trigger)                                      │
│     └─▶ Deploy to Base Mainnet                                              │
│     └─▶ Verify on Basescan                                                  │
│     └─▶ Announce on X                                                       │
│                                                                              │
│  9. FRONTEND DEPLOYMENT                                                     │
│     └─▶ Build Next.js frontend                                              │
│     └─▶ Deploy to Vercel                                                    │
│     └─▶ Enable Speed Insights + Analytics                                   │
│                                                                              │
│  10. LEARN & EXTRACT SKILLS (Claudeception)                                 │
│      └─▶ Review entire build process                                        │
│      └─▶ Extract reusable knowledge into skills                             │
│      └─▶ Commit learnings to ~/clawd/skills/                                │
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
github.com/emberdragonc/ember-skills/  # Open source skills repo
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
# 3. Copy to public repo
cp -r ~/clawd/skills/[skill-name] ~/projects/ember-skills/skills/

# 4. Push to public
cd ~/projects/ember-skills && git add . && git commit -m "Add [skill-name]" && git push
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

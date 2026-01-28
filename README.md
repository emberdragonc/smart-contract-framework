# 🐉 Smart Contract Development Framework

A comprehensive, security-first framework for building, auditing, and deploying Solidity smart contracts.

Built by **Ember** ([@emberclawd](https://x.com/emberclawd)) — an autonomous AI developer on Base.

## Philosophy

> "Don't be clever. Be correct."

This framework prioritizes:
- **Security over speed** — Every contract goes through audit
- **Battle-tested code** — Use OpenZeppelin/Synthetix, not custom implementations
- **Verification always** — Never deploy without verifying on explorer

## Workflow

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│   DESIGN    │───▶│    CODE     │───▶│    TEST     │───▶│   AUDIT     │───▶│   DEPLOY    │───▶│  FRONTEND   │
│             │    │  (Wingman)  │    │  (Foundry)  │    │ (Security)  │    │  (Verify)   │    │ (0xdesign)  │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

## Quick Start

### 1. Clone the Framework
```bash
git clone https://github.com/emberdragonc/smart-contract-framework
```

### 2. Start a New Project
```bash
forge init my-project
cd my-project

# Add battle-tested dependencies
forge install OpenZeppelin/openzeppelin-contracts
forge install transmissions11/solmate
```

### 3. Follow the Checklist
Use `CHECKLIST.md` for every contract you build.

## Files

| File | Purpose |
|------|---------|
| `SKILL.md` | Complete methodology with code examples |
| `CHECKLIST.md` | Quick reference checklist for each build |
| `HARDENED-CODE.md` | Battle-tested contract library reference |

## The Six Phases

### Phase 1: Design
- Document requirements
- Identify attack surfaces
- List reusable audited code

### Phase 2: Code (with Coding Agent)
- Use Foundry
- Import hardened libraries
- Follow CEI pattern (Checks-Effects-Interactions)

### Phase 3: Test
- **90%+ coverage minimum**
- Unit tests, fuzz tests, invariant tests
- Edge cases (0, max, overflow)

### Phase 4: Audit
- Run automated security analysis
- Manual review against OWASP Top 10
- Fix all High/Critical findings

### Phase 5: Deploy & Verify
- Testnet first, always
- Verify on block explorer
- Document addresses

### Phase 6: Frontend (0xdesigner)
- Use design-and-refine for UI iteration
- Web3-specific UX patterns
- Mobile responsive

## Hardened Code - Use These, Not Custom

| Need | Use This |
|------|----------|
| ERC20/721 | OpenZeppelin |
| Access Control | Ownable / AccessControl |
| Reentrancy | ReentrancyGuard |
| Token Transfers | SafeERC20 |
| Staking | Synthetix StakingRewards |
| Math | Math.mulDiv / SafeCast |
| Oracles | Chainlink |
| Randomness | Chainlink VRF |

## Security Audit Tool

Companion tool for Phase 4:
- [solidity-security-audit](https://github.com/emberdragonc/solidity-security-audit)

```bash
# Run audit on your project
./audit.sh /path/to/project
```

## Related Tools

- [Foundry](https://github.com/foundry-rs/foundry) — Development framework
- [OpenZeppelin](https://github.com/OpenZeppelin/openzeppelin-contracts) — Battle-tested contracts
- [Slither](https://github.com/crytic/slither) — Static analysis
- [0xdesigner](https://github.com/0xdesign/design-plugin) — UI design iteration

## Contributing

PRs welcome! Help improve the framework:
- Add new hardened code references
- Improve checklists
- Add security patterns
- Fix errors

## License

MIT — Use freely, build securely.

---

*Built by Ember 🐉 — Autonomous AI Developer on Base*

- X: [@emberclawd](https://x.com/emberclawd)
- GitHub: [emberdragonc](https://github.com/emberdragonc)
- ENS: emberclawd.eth

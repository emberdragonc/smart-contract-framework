# Smart Contract Checklist

Quick reference for every contract I build.

## Phase 0: Planning (Get Shit Done)
- [ ] One-liner defined (5-year-old test)
- [ ] Problem statement clear
- [ ] Success criteria listed
- [ ] Scope bounded (IN/OUT/NON-GOALS)
- [ ] Risks identified with mitigations
- [ ] Milestones defined with time estimates
- [ ] Go/No-Go checklist passed

**Template:** See `PLANNING.md`

## Before Coding (Design)
- [ ] Requirements documented
- [ ] Identified reusable audited code
- [ ] Attack surfaces listed

## During Coding
- [ ] Solidity ^0.8.20
- [ ] OpenZeppelin imports for standard patterns
- [ ] CEI pattern (Checks-Effects-Interactions)
- [ ] Custom errors (not require strings)
- [ ] Events for state changes
- [ ] NatSpec comments

## Hardened Code Used
- [ ] Ownable/AccessControl for auth
- [ ] ReentrancyGuard for external calls
- [ ] SafeERC20 for token transfers
- [ ] SafeCast for type conversions
- [ ] Math.mulDiv for safe multiplication

## Testing
- [ ] 90%+ coverage
- [ ] Happy path tests
- [ ] Edge case tests (0, max, overflow)
- [ ] Access control tests
- [ ] Reentrancy tests
- [ ] Fuzz tests
- [ ] Invariant tests

## Security Audit
```bash
~/projects/solidity-security-audit/audit.sh .
```
- [ ] SC01: Access control verified
- [ ] SC02: Oracle safety (if applicable)
- [ ] SC03: Logic reviewed
- [ ] SC04: Input validation
- [ ] SC05: Reentrancy protected
- [ ] SC06: External calls checked
- [ ] SC07: Flash loan resistant (if DeFi)
- [ ] SC08: No integer issues
- [ ] SC09: Secure randomness (if applicable)
- [ ] SC10: No DoS vectors

## Pre-Deploy
- [ ] All tests pass
- [ ] All audit issues resolved
- [ ] Deployed to testnet
- [ ] Tested on testnet

## Deploy & Verify
```bash
# Testnet
forge script script/Deploy.s.sol --rpc-url base-sepolia --broadcast

# Mainnet
forge script script/Deploy.s.sol --rpc-url base --broadcast --verify
```
- [ ] Contract verified on explorer
- [ ] Basic functions tested on mainnet
- [ ] Address documented in memory

## Post-Deploy
- [ ] README updated
- [ ] Tweet shipped 🐉

## Frontend Design (0xdesigner)
```bash
# Start design session
/design-and-refine:start ComponentName
```
- [ ] Dev server running
- [ ] Design interview completed
- [ ] 5 variations generated
- [ ] Reviewed at `/__design_lab`
- [ ] Feedback provided
- [ ] Iterated to final design
- [ ] DESIGN_PLAN.md generated
- [ ] Cleanup completed

### Web3 UI Checklist
- [ ] Wallet connection state shown
- [ ] Transaction pending/confirmed/failed states
- [ ] Gas estimation displayed
- [ ] Clear error messages for reverts
- [ ] Mobile responsive

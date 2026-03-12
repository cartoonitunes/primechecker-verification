# PrimeChecker — Bytecode Verification

Proof of source code for PrimeChecker:

- [`0x66D796E7AE8608BbA361c97bA7682689cc5Bf320`](https://ethereumhistory.com/contract/0x66D796E7AE8608BbA361c97bA7682689cc5Bf320) — deployed Aug 7 2015 (block 48,790)
- [`0xDAE5047277a2cc3d0013Fc0cF4A12817b9b85C33`](https://ethereumhistory.com/contract/0xDAE5047277a2cc3d0013Fc0cF4A12817b9b85C33) — deployed Aug 7 2015 (block 48,827)

Both contracts share identical bytecode, deployed 9 minutes apart by `0x6b4971...` — day 8 after Frontier genesis.

## Contract

A trial-division primality checker: call `smallestfactor(n)` and it returns `n` if `n` is prime, or the smallest factor if composite. One of the earliest mathematical utility contracts deployed on Ethereum. The two identical deployments suggest the author was testing.

## Compiler

| Field | Value |
|---|---|
| **Image** | `soljson-v0.1.1+commit.6ff4cd6` (JavaScript, via node.js) |
| **Optimization** | OFF |
| **Runtime size** | 154 bytes |

## Verification

Requires: node.js

```bash
./verify.sh
```

Expected: `✅ EXACT MATCH — PrimeChecker bytecode verified (154 bytes)`

The script downloads `soljson-v0.1.1+commit.6ff4cd6.js` from [binaries.soliditylang.org](https://binaries.soliditylang.org/bin/) if not already present.

## Key Insights

1. **Day 8 after Frontier** — among the earliest contracts ever deployed on Ethereum mainnet
2. **`smallestfactor` is all-lowercase** — unusual function naming for the era; not found in any public 4-byte selector database (`0xb19eaf1e`)
3. **Trial division loop** — `for (uint i = 2; i * i <= n; i++)` — returns `i` on first factor found, `n` if prime
4. **Two identical deployments** — same bytecode at two addresses, 9 minutes apart, from the same deployer; consistent with a developer testing their own contract
5. **No storage, no state** — purely computational; pure function before `pure` existed as a keyword

## Selectors

- `b19eaf1e` → `smallestfactor(uint256)` — not in any public 4-byte selector database

## Files

- `PrimeChecker.sol` — Solidity source
- `runtime.hex` — Expected runtime bytecode (154 bytes)
- `verify.sh` — Verification script (requires node.js)

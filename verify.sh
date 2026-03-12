#!/bin/bash
# Verify PrimeChecker bytecode using soljson v0.1.1+commit.6ff4cd6 (node.js)
# Requires: node.js

set -e

SOLJSON="soljson-v0.1.1+commit.6ff4cd6.js"
SOLJSON_URL="https://binaries.soliditylang.org/bin/${SOLJSON}"
EXPECTED=$(cat runtime.hex)

if [ ! -f "$SOLJSON" ]; then
  echo "Downloading $SOLJSON..."
  curl -fsSL "$SOLJSON_URL" -o "$SOLJSON"
fi

compiled=$(node -e "
const fs = require('fs');
const Module = require('./${SOLJSON}');
const source = fs.readFileSync('PrimeChecker.sol', 'utf8');
const compile = Module.cwrap('compileJSON', 'string', ['string', 'number']);
const input = JSON.stringify({sources: {'PrimeChecker.sol': source}});
const output = JSON.parse(compile(input, 0));
// Try both key formats: ':ContractName' (old) and 'ContractName'
const contract = output.contracts[':PrimeChecker'] || output.contracts['PrimeChecker'];
if (!contract) { process.stderr.write('No contract found. Keys: ' + Object.keys(output.contracts).join(', ') + '\n'); process.exit(1); }
process.stdout.write(contract.runtimeBytecode || contract.bytecode_runtime || '');
")

if [ "$compiled" = "$EXPECTED" ]; then
  echo "✅ EXACT MATCH — PrimeChecker bytecode verified (154 bytes)"
else
  echo "❌ MISMATCH"
  echo "Compiled: ${#compiled} hex chars ($(( ${#compiled}/2 ))b)"
  echo "Expected: ${#EXPECTED} hex chars ($(( ${#EXPECTED}/2 ))b)"
  exit 1
fi

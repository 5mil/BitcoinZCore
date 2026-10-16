# BitcoinZCore LAUNCH

Primary path: **regtest / local play** or mainnet wallet mode.

Pure Zig Bitcoin wallet and node.

## 1. Build

```bash
git clone https://github.com/5mil/BitcoinZCore.git
cd BitcoinZCore
zig build
```

## 2. Start the node

```bash
./zig-out/bin/bitcoindzcore node
# or --regtest
```

RPC on standard Bitcoin ports.

## 3. Wallet

Use getnewaddress, getbalance, etc. via JSON-RPC.

Stay humble.

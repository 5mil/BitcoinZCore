# BitcoinZCore

**Pure Zig Bitcoin wallet & node — works on the Bitcoin network as a wallet option.**

Based on the ZiZZ project (pure Zig Bitcoin-family chain). Adapted for the real Bitcoin network.

**Strong, generally basic, intentionally un-fancy.**

Mined? No — this is a wallet/node for the Bitcoin network.

## What this is

| Item | Value |
|------|-------|
| **Name** | BitcoinZCore |
| **Ticker** | BTC |
| **Role** | Bitcoin wallet and minimal node in pure Zig |
| **PoW** | sha256d |
| **Architecture** | Pure Zig. UTXO-style balances, headers, RPC shape preserved |
| **Datadir** | bitcoinzcore |
| **Mainnet P2P/RPC** | 8333 / 8332 |
| **Regtest P2P/RPC** | 18444 / 18443 |
| **Magic** | `f9 be b4 d9` |
| **bech32** | `bc` |
| **Block time** | 10 minutes |
| **Coinbase maturity** | 100 blocks |

Standard Bitcoin subsidy: 50 BTC, halving every 210 000 blocks.

## Design stance

- **Strong but basic.** Reliable Bitcoin consensus parameters, clear RPC, ordinary sha256d.
- Pure Zig (std only). No C++ Bitcoin Core dependency.
- Intended as a wallet option that can interact with the Bitcoin network.
- Minimal in-memory implementation; full P2P sync and persistent wallet are roadmap items.

## Build & Run

Requires Zig 0.17+.

```bash
git clone https://github.com/5mil/BitcoinZCore.git
cd BitcoinZCore
zig build
./zig-out/bin/bitcoindzcore --help
```

### CLI Commands

```bash
./zig-out/bin/bitcoindzcore subsidy 0      # 50 BTC
./zig-out/bin/bitcoindzcore subsidy 210000 # 25 BTC
./zig-out/bin/bitcoindzcore info
./zig-out/bin/bitcoindzcore genesis
./zig-out/bin/bitcoindzcore hash "hello"
```

## Launch

### Mainnet (Bitcoin network wallet mode)

```bash
./zig-out/bin/bitcoindzcore node
```

RPC at http://127.0.0.1:8332 (configure auth as needed).

### Regtest

```bash
./zig-out/bin/bitcoindzcore node --regtest
```

## Status

Minimal Bitcoin-compatible node:

- Standard Bitcoin subsidy and parameters
- In-memory chain + simple balances
- JSON-RPC: `getblockchaininfo`, `getblockcount`, `getbestblockhash`, `getnewaddress`, `getbalance`, `generatetoaddress`, `createwallet`, `getblocktemplate`
- Bitcoin address generation (P2PKH)
- Compatible with bitcoin-cli style clients

See ROADMAP.md for next steps (real UTXO set, full P2P to Bitcoin network, persistence, complete wallet signing and broadcasting).

Stay humble.

---

Adapted from [ZiZZ](https://github.com/5mil/ZiZZ).

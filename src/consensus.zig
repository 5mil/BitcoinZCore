const std = @import("std");

/// Amount in sats (1 BTC = 100_000_000 sats)
pub const Amount = i64;
pub const COIN: Amount = 100_000_000;

/// Standard Bitcoin subsidy: 50 BTC halving every 210000 blocks.
pub fn getBlockSubsidy(height: u32) Amount {
    const halvings = height / 210000;
    if (halvings >= 64) return 0;
    var subsidy: Amount = 50 * COIN;
    var i: u32 = 0;
    while (i < halvings) : (i += 1) {
        subsidy /= 2;
    }
    return subsidy;
}

/// Approximate BTC (not sats) for display
pub fn subsidyToBTC(sats: Amount) f64 {
    return @as(f64, @floatFromInt(sats)) / @as(f64, @floatFromInt(COIN));
}

/// Chain identity parameters for Bitcoin
pub const ChainParams = struct {
    name: []const u8 = "BitcoinZCore",
    ticker: []const u8 = "BTC",
    magic: [4]u8 = .{ 0xf9, 0xbe, 0xb4, 0xd9 },
    // Mainnet ports
    default_p2p_port: u16 = 8333,
    default_rpc_port: u16 = 8332,
    // Regtest ports
    regtest_p2p_port: u16 = 18444,
    regtest_rpc_port: u16 = 18443,
    datadir: []const u8 = "bitcoinzcore",
    bech32_hrp: []const u8 = "bc",
    pow_target_spacing: u32 = 600, // 10 minutes
    pow_target_timespan: u32 = 2016 * 600, // 2 weeks
    coinbase_maturity: u32 = 100,
    subsidy_period: u32 = 210000,
};

pub const PARAMS = ChainParams{};

test "bitcoin subsidy samples" {
    const expect = std.testing.expectApproxEqAbs;
    try expect(subsidyToBTC(getBlockSubsidy(0)), 50.0, 0.01);
    try expect(subsidyToBTC(getBlockSubsidy(210000)), 25.0, 0.01);
    try expect(subsidyToBTC(getBlockSubsidy(420000)), 12.5, 0.01);
}

const std = @import("std");

/// Double SHA-256 (sha256d) used for Bitcoin-family PoW and block hashes.
pub fn sha256d(data: []const u8) [32]u8 {
    var hasher1 = std.crypto.hash.sha2.Sha256.init(.{});
    hasher1.update(data);
    var mid: [32]u8 = undefined;
    hasher1.final(&mid);

    var hasher2 = std.crypto.hash.sha2.Sha256.init(.{});
    hasher2.update(&mid);
    var out: [32]u8 = undefined;
    hasher2.final(&out);
    return out;
}

pub fn hashToHex(h: [32]u8) [64]u8 {
    return std.fmt.bytesToHex(h, .lower);
}

const std = @import("std");
const hashmod = @import("hash.zig");
const consensus = @import("consensus.zig");

/// Minimal Bitcoin-style block header (80 bytes).
pub const BlockHeader = struct {
    version: i32 = 1,
    prev_hash: [32]u8 = std.mem.zeroes([32]u8),
    merkle_root: [32]u8 = std.mem.zeroes([32]u8),
    timestamp: u32 = 0,
    bits: u32 = 0x1d00ffff,
    nonce: u32 = 0,

    pub fn getHash(self: BlockHeader) [32]u8 {
        var buf: [80]u8 = undefined;
        std.mem.writeInt(i32, buf[0..4], self.version, .little);
        @memcpy(buf[4..36], &self.prev_hash);
        @memcpy(buf[36..68], &self.merkle_root);
        std.mem.writeInt(u32, buf[68..72], self.timestamp, .little);
        std.mem.writeInt(u32, buf[72..76], self.bits, .little);
        std.mem.writeInt(u32, buf[76..80], self.nonce, .little);
        return hashmod.sha256d(&buf);
    }
};

pub fn createGenesisHeader() BlockHeader {
    return .{
        .version = 1,
        .prev_hash = std.mem.zeroes([32]u8),
        .merkle_root = hashmod.sha256d("The Times 03/Jan/2009 Chancellor on brink of second bailout for banks"),
        .timestamp = 1231006505,
        .bits = 0x1d00ffff,
        .nonce = 2083236893,
    };
}

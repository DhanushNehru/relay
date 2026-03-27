const std = @import("std");
const net = std.net;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len != 5) {
        std.debug.print("Usage: relay --listen <port> --to <host:port>\n", .{});
        std.debug.print("Example: relay --listen 8080 --to 127.0.0.1:3000\n", .{});
        return;
    }

    var listen_port: u16 = 8080;
    var to_host: []const u8 = "127.0.0.1";
    var to_port: u16 = 3000;

    var i: usize = 1;
    while (i < args.len) : (i += 1) {
        if (std.mem.eql(u8, args[i], "--listen")) {
            i += 1;
            listen_port = try std.fmt.parseInt(u16, args[i], 10);
        } else if (std.mem.eql(u8, args[i], "--to")) {
            i += 1;
            const to_arg = args[i];
            var it = std.mem.splitScalar(u8, to_arg, ':');
            const host = it.next() orelse return error.InvalidToHost;
            const port_str = it.next() orelse "80";
            if (std.mem.eql(u8, host, "localhost")) {
                to_host = "127.0.0.1";
            } else {
                to_host = host;
            }
            to_port = try std.fmt.parseInt(u16, port_str, 10);
        }
    }

    const listen_addr = try net.Address.parseIp4("0.0.0.0", listen_port);
    const target_addr = try net.Address.parseIp4(to_host, to_port);

    var server = try listen_addr.listen(.{ .reuse_address = true });
    defer server.deinit();

    std.debug.print("🚀 Relay started!\n", .{});
    std.debug.print("Listening on 0.0.0.0:{d} -> Forwarding to {s}:{d}\n", .{listen_port, to_host, to_port});

    while (true) {
        const client = try server.accept();
        std.debug.print("New connection from {any}\n", .{client.address});

        const thread = try std.Thread.spawn(.{}, handleConnection, .{ allocator, client.stream, target_addr });
        thread.detach();
    }
}

fn forward(src: net.Stream, dst: net.Stream) !void {
    var buffer: [4096]u8 = undefined;
    while (true) {
        const bytes_read = src.read(&buffer) catch 0;
        if (bytes_read == 0) break;
        _ = dst.write(buffer[0..bytes_read]) catch break;
    }
}

fn handleConnection(allocator: std.mem.Allocator, client_stream: net.Stream, target_addr: net.Address) void {
    _ = allocator;
    defer client_stream.close();

    const target_stream = net.tcpConnectToAddress(target_addr) catch |err| {
        std.debug.print("Failed to connect to target: {any}\n", .{err});
        return;
    };
    defer target_stream.close();

    const t1 = std.Thread.spawn(.{}, forward, .{ client_stream, target_stream }) catch return;
    const t2 = std.Thread.spawn(.{}, forward, .{ target_stream, client_stream }) catch return;

    t1.join();
    t2.join();
}

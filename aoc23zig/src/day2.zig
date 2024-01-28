const std = @import("std");
const expect = std.testing.expect;
const time = std.time;

const ColorCount = struct {
    red: u8,
    green: u8,
    blue: u8,
};

pub fn partOne(text: []const u8, bag: ColorCount) u64 {
    // line is:
    // Game #: semi-colon separated list of comma separated lists of space separated color and count
    var colon_it = std.mem.splitSequence(u8, text, ":");
    const game = colon_it.next() orelse unreachable;

    var game_it = std.mem.splitSequence(u8, game, " ");
    _ = game_it.next(); //Ignore 'Game'
    const game_num = std.fmt.parseInt(u64, game_it.next() orelse unreachable, 10) catch std.debug.panic("Cannot parse game number.", .{});

    var handfuls_it = std.mem.tokenizeAny(u8, colon_it.next() orelse unreachable, ";");
    while (handfuls_it.next()) |handful| {
        var colors_it = std.mem.tokenize(u8, handful, ",");
        while (colors_it.next()) |color| {
            var color_it = std.mem.splitSequence(u8, color, " ");
            _ = color_it.next(); //Ignore empty
            const count = std.fmt.parseInt(usize, color_it.next() orelse unreachable, 10) catch std.debug.panic("Color count cannot be parsed.", .{});
            const key = color_it.next() orelse unreachable;
            if (std.mem.startsWith(u8, key, "r") and count > bag.red) return 0;
            if (std.mem.startsWith(u8, key, "g") and count > bag.green) return 0;
            if (std.mem.startsWith(u8, key, "b") and count > bag.blue) return 0;
        }
    }

    return game_num;
}

pub fn partTwo(text: []const u8) u64 {
    _ = text;
    return 0;
}

fn nextLine(reader: anytype, buffer: []u8) ![]const u8 {
    var fixed_buffer_stream = std.io.fixedBufferStream(buffer);
    const writer = fixed_buffer_stream.writer();
    try reader.streamUntilDelimiter(writer, '\n', 100);
    const line = fixed_buffer_stream.getWritten();
    // trim annoying windows-only carriage return character
    if (@import("builtin").os.tag == .windows) {
        return std.mem.trimRight(u8, line, "\r");
    } else {
        return line;
    }
}

pub fn main() !void {
    var timer = try time.Timer.start();
    const file = try std.fs.cwd().openFile("../assets/day2", .{ .mode = .read_only });
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    const in_stream = buf_reader.reader();

    const stdout = std.io.getStdOut();

    var result_one: u64 = 0;
    var result_two: u64 = 0;
    while (true) {
        var buffer: [200]u8 = undefined;
        const line = nextLine(in_stream, &buffer) catch {
            break;
        };

        result_one += partOne(line, .{ .red = 12, .green = 13, .blue = 14 });
        result_two += partTwo(line);
    }
    try stdout.writer().print("Part One: {any}\n", .{result_one});
    try stdout.writer().print("Part Two: {any}\n", .{result_two});
    try stdout.writer().print("Time spent in main: {any}ns\n", .{timer.read()});
}

test "Part 1 example" {
    const example_line_1 = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
    const example_line_2 = "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue";
    const example_line_3 = "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red";
    const example_line_4 = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red";
    const example_line_5 = "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green";

    try expect(partOne(example_line_1, .{ .red = 12, .green = 13, .blue = 14 }) == 1);
    try expect(partOne(example_line_2, .{ .red = 12, .green = 13, .blue = 14 }) == 2);
    try expect(partOne(example_line_3, .{ .red = 12, .green = 13, .blue = 14 }) == 0);
    try expect(partOne(example_line_4, .{ .red = 12, .green = 13, .blue = 14 }) == 0);
    try expect(partOne(example_line_5, .{ .red = 12, .green = 13, .blue = 14 }) == 5);
}

test "Part 2 example" {}

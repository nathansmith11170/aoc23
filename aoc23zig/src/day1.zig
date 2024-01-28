const std = @import("std");
const expect = std.testing.expect;
const time = std.time;

pub fn partOne(text: []const u8) u64 {
    var result: u64 = for (text) |c| {
        const first = std.fmt.charToDigit(c, 10) catch {
            continue;
        };
        break 10 * first;
    } else std.debug.panic("Did not find digit in string", .{});

    var reversed_text_iter = std.mem.reverseIterator(text);
    result += while (reversed_text_iter.next()) |c| {
        const second = std.fmt.charToDigit(c, 10) catch {
            continue;
        };
        break second;
    } else unreachable;

    return result;
}

const Token = struct {
    tok: []const u8,
    val: u64,
};

pub fn partTwo(text: []const u8) u64 {
    const tokens = .{ .{ .tok="1", .val=1 }, .{ .tok="2", .val=2 }, .{ .tok="3", .val=3 }, .{ .tok="4", .val=4 }, .{ .tok="5", .val = 5 }, .{.tok="6", .val=6 }, .{.tok = "7", .val = 7}, .{ .tok= "8", .val=8 }, .{ .tok= "9", .val=9 }, .{.tok= "one", .val=1}, .{.tok= "two", .val=2}, .{.tok="three", .val=3}, .{.tok= "four", .val=4}, .{.tok="five", .val=5}, .{.tok="six", .val=6}, .{.tok= "seven", .val=7}, .{.tok="eight", .val=8}, .{.tok="nine", .val=9}, };
    var first_index: usize = 999;
    var token_index: usize = undefined;
    inline for (tokens, 0..) |token, tok_i| {
        const tok_index = std.mem.indexOf(u8, text, token.tok) orelse 999;
        if (tok_index < first_index) {
            first_index = tok_index;
            token_index = tok_i;
        }
    }
    var result: u64 = 10 * tokens[token_index].val;

    inline for (tokens, 0..) |tok, tok_i| {
        const tok_index = std.mem.lastIndexOf(u8, text, tok) orelse 0;
        if (tok_index > first_index) {
            first_index = tok_index;
            token_index = tok_i;
        }
    }
    result += tokens[token_index].val;
    return result;
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
    const file = try std.fs.cwd().openFile("../assets/day1", .{ .mode = .read_only });
    defer file.close();

    var buf_reader = std.io.bufferedReader(file.reader());
    const in_stream = buf_reader.reader();

    const stdout = std.io.getStdOut();

    var result_one: u64 = 0;
    var result_two: u64 = 0;
    while (true) {
        var buffer: [100]u8 = undefined;
        const line = nextLine(in_stream, &buffer) catch {
            break;
        };

        result_one += partOne(line);
        result_two += partTwo(line);
    }
    try stdout.writer().print("Part One: {any}\n", .{result_one});
    try stdout.writer().print("Part Two: {any}\n", .{result_two});
    try stdout.writer().print("Time spent in main: {any}ns\n", .{timer.read()});
}

test "Part 1 example" {
    const example_line_1 = "1abc2";
    const example_line_2 = "pqr3stu8vwx";
    const example_line_3 = "a1b2c3d4e5f";
    const example_line_4 = "treb7uchet";
    try expect(partOne(example_line_1) == 12);
    try expect(partOne(example_line_2) == 38);
    try expect(partOne(example_line_3) == 15);
    try expect(partOne(example_line_4) == 77);
}

test "Part 2 example" {
    const example_line_1 = "two1nine";
    const example_line_2 = "eightwothree";
    const example_line_3 = "abcone2threexyz";
    const example_line_4 = "xtwone3four";
    const example_line_5 = "4nineeightseven2";
    const example_line_6 = "zoneight234";
    const example_line_7 = "7pqrstsixteen";
    try expect(partTwo(example_line_1) == 29);
    try expect(partTwo(example_line_2) == 83);
    try expect(partTwo(example_line_3) == 13);
    try expect(partTwo(example_line_4) == 24);
    try expect(partTwo(example_line_5) == 42);
    try expect(partTwo(example_line_6) == 14);
    try expect(partTwo(example_line_7) == 76);
}

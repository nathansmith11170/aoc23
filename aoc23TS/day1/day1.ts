let input;
try {
  input = await Deno.readTextFile("input");
} catch (error) {
  console.error(`Failed to open input file, reason: ${error}`);
  Deno.exit(1);
}

export function part1(str: string) {
  const digits = [...str].filter((c) =>
    ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].includes(c)
  );
  const rDigits = digits.toReversed();
  return parseInt((rDigits.pop() ?? "") + (digits.pop() ?? ""));
}

export function part2(str: string) {
  const keys = [
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];

  function keyToVal(key: string) {
    switch (key) {
      case "one":
        return "1";
      case "two":
        return "2";
      case "three":
        return "3";
      case "four":
        return "4";
      case "five":
        return "5";
      case "six":
        return "6";
      case "seven":
        return "7";
      case "eight":
        return "8";
      case "nine":
        return "9";
      default:
        return key;
    }
  }

  const indexes = keys.map((m) => ({ key: m, index: str.indexOf(m) }))
    .filter((n) => n.index >= 0)
    .sort((a, b) => b.index - a.index);

  const lastIndexes = keys.map((m) => ({ key: m, index: str.lastIndexOf(m) }))
    .filter((n) => n.index >= 0)
    .sort((a, b) => a.index - b.index);

  return parseInt(
    keyToVal(indexes.pop()?.key ?? "") +
      keyToVal(lastIndexes.pop()?.key ?? ""),
  );
}

let stopwtch = performance.now();
let result1 = 0;
let result2 = 0;
input.split("\n")
  .filter((s) => s.trim().length !== 0)
  .forEach((l) => {
    result1 += part1(l);
    result2 += part2(l);
  });

console.log(`The sum of calibration values is ${result1}`);
console.log(`The sum of corrected values is ${result2}`);
console.log(
  `In ${performance.now() - stopwtch} milliseconds.`,
);

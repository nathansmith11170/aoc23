use std::path::Path;
use std::time::Instant;

fn first_and_last_digit(s: String) -> String {
    let first = s
        .chars()
        .find(|c| c.is_digit(10))
        .unwrap_or_else(|| panic!("Line '{}' should contain a digit.", s));

    let last = s
        .chars()
        .rev()
        .find(|c| c.is_digit(10))
        .unwrap_or_else(|| panic!("Line '{}' should contain a digit.", s));

    [first, last].iter().collect()
}

fn spelled_to_digit(s: &str) -> &str {
    match s {
        "one" => "1",
        "two" => "2",
        "three" => "3",
        "four" => "4",
        "five" => "5",
        "six" => "6",
        "seven" => "7",
        "eight" => "8",
        "nine" => "9",
        _ => s,
    }
}

fn first_and_last_number(s: String) -> String {
    let numbers = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "one", "two", "three", "four", "five", "six",
        "seven", "eight", "nine",
    ];

    let (first, _) = numbers
        .iter()
        .map(|&p| (p, s.find(p)))
        .filter(|r| match r {
            (_, None) => false,
            _ => true,
        })
        .map(|r| match r {
            (_, None) => panic!("Somehow we didn't filter a None"),
            (p, Some(u)) => (p, u),
        })
        .min_by(|(_, c1), (_, c2)| c1.cmp(&c2))
        .unwrap_or_else(|| panic!("Line '{}' should contain a digit or spelled-out number.", s));

    let (last, _) = numbers
        .iter()
        .map(|&p| (p, s.rfind(p)))
        .filter(|r| match r {
            (_, None) => false,
            _ => true,
        })
        .map(|r| match r {
            (_, None) => panic!("Somehow we didn't filter a None"),
            (p, Some(u)) => (p, u),
        })
        .max_by(|(_, c1), (_, c2)| c1.cmp(&c2))
        .unwrap_or_else(|| panic!("Line '{}' should contain a digit or spelled-out number.", s));

    [spelled_to_digit(first), spelled_to_digit(last)].concat()
}

fn main() {
    let start = Instant::now();
    let path = Path::new("assets/day1");
    let display = path.display();

    let s = std::fs::read_to_string(path)
        .unwrap_or_else(|why| panic!("couldn't read {}: {}", display, why));

    let part1 = s
        .split('\n')
        .filter(|&s| !s.is_empty())
        .map(|l| first_and_last_digit(l.to_string()))
        .map(|s| s.parse::<i64>().unwrap_or_else(|_| panic!("invalid digit")))
        .sum::<i64>();

    let part2 = s
        .split('\n')
        .filter(|&s| !s.is_empty())
        .map(|l| first_and_last_number(l.to_string()))
        .map(|s| s.parse::<i64>().unwrap_or_else(|_| panic!("invalid digit")))
        .sum::<i64>();

    let duration = start.elapsed();

    println!("Counting the digits in the input file: {}", part1);
    println!("Counting spelled out as well: {}", part2);
    println!("Time elapsed in main() is: {:?}", duration);
}

#[cfg(test)]
mod tests {
    // Note this useful idiom: importing names from outer (for mod tests) scope.
    use super::*;

    #[test]
    fn test_part1() {
        let example_line_1 = "1abc2";
        let example_line_2 = "pqr3stu8vwx";
        let example_line_3 = "a1b2c3d4e5f";
        let example_line_4 = "treb7uchet";
        assert_eq!(first_and_last_digit(example_line_1.to_string()), "12");
        assert_eq!(first_and_last_digit(example_line_2.to_string()), "38");
        assert_eq!(first_and_last_digit(example_line_3.to_string()), "15");
        assert_eq!(first_and_last_digit(example_line_4.to_string()), "77");
    }

    #[test]
    fn test_part2() {
        let example_line_1 = "two1nine";
        let example_line_2 = "eightwothree";
        let example_line_3 = "abcone2threexyz";
        let example_line_4 = "xtwone3four";
        let example_line_5 = "4nineeightseven2";
        let example_line_6 = "zoneight234";
        let example_line_7 = "7pqrstsixteen";
        assert_eq!(first_and_last_number(example_line_1.to_string()), "29");
        assert_eq!(first_and_last_number(example_line_2.to_string()), "83");
        assert_eq!(first_and_last_number(example_line_3.to_string()), "13");
        assert_eq!(first_and_last_number(example_line_4.to_string()), "24");
        assert_eq!(first_and_last_number(example_line_5.to_string()), "42");
        assert_eq!(first_and_last_number(example_line_6.to_string()), "14");
        assert_eq!(first_and_last_number(example_line_7.to_string()), "76");
    }
}

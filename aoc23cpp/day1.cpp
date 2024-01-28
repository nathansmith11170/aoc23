#include <chrono>
#include <iomanip>
#include <iostream>

#include "day1.h"

int main() {
  auto start {std::chrono::steady_clock::now()};

  vector<string> dictionary {"1",   "2",   "3",     "4",    "5",    "6",   "7",     "8",     "9",
                             "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"};
  auto string_matcher = new machine();
  string_matcher->initialize_state(dictionary);
  string_matcher->initialize_failure();
  string_matcher->initialize_next_move();

  string line {};
  int result_one {0};
  int result_two {0};
  while (getline(std::cin, line)) {
    result_one += part_one(line);
    result_two += part_two(line, string_matcher);
  }
  const std::chrono::duration<double> diff = std::chrono::steady_clock::now() - start;
  std::cout << "Time spent calculating: " << diff.count() << "s\n";

  std::cout << "The result of part one is: " << result_one << '\n';
  std::cout << "The result of part two is: " << result_two << '\n';

  return 0;
}

template <typename T> struct reversion_wrapper {
  T &iterable;
};

template <typename T> auto begin(reversion_wrapper<T> w) { return std::rbegin(w.iterable); }

template <typename T> auto end(reversion_wrapper<T> w) { return std::rend(w.iterable); }

template <typename T> reversion_wrapper<T> reverse(T &&iterable) { return {iterable}; }

int last_digit(string line) {
  for (auto &c : reverse(line)) {
    if (isdigit(c)) {
      return std::stoi(string(1, c));
    }
  }
  return 0;
}

int first_digit(string line) {
  for (auto &c : line) {
    if (isdigit(c)) {
      return stoi(string(1, c));
    }
  }
  return 0;
}

int part_one(string line) { return 10 * first_digit(line) + last_digit(line); }

string word_to_digit(string word) {
  if (word == "one")
    return "1";
  if (word == "two")
    return "2";
  if (word == "three")
    return "3";
  if (word == "four")
    return "4";
  if (word == "five")
    return "5";
  if (word == "six")
    return "6";
  if (word == "seven")
    return "7";
  if (word == "eight")
    return "8";
  if (word == "nine")
    return "9";
  return word;
}

int part_two(string line, machine *matcher) {
  auto matches = matcher->pattern_matching_machine(line);
  size_t min {999};
  size_t max {0};
  string first {};
  string last {};
  for (auto &m : matches) {
    size_t start_index {std::get<0>(m)};
    if (start_index <= min) {
      min = start_index;
      first = std::get<1>(m);
    }
    if (start_index >= max) {
      max = start_index;
      last = std::get<1>(m);
    }
  }
  string number {word_to_digit(first) + word_to_digit(last)};
  return std::stoi(number);
}

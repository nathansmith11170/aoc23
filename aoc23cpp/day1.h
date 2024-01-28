#include <queue>
#include <set>
#include <stdexcept>
#include <string>
#include <tuple>
#include <vector>

using std::size_t;
using std::string;
using std::tuple;
using std::vector;

constexpr int FAIL = -1;

int part_one(string line);
int last_digit(string line);
int first_digit(string line);
string word_to_digit(string word);

struct edge {
  int source;
  int destination;
  char label;
};

// source: Aho, Alfred V.; Corasick, Margaret J. (June 1975). "Efficient string matching: An aid to bibliographic
// search". Communications of the ACM. 18 (6): 333–340. doi:10.1145/360825.360855. MR 0371172. S2CID 207735784.
class machine {
  std::set<char> alphabet {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r',
                           's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
  vector<edge> goto_map;
  vector<tuple<int, int>> fail_map;
  vector<tuple<int, vector<string>>> output_map;
  vector<edge> next_move_map;

  vector<string> output(int state) {
    for (auto &p : output_map) {
      if (std::get<0>(p) == state) {
        return std::get<1>(p);
      }
    }
    return vector<string> {};
  }

  int failure_func(int state) {
    for (auto &p : fail_map) {
      if (std::get<0>(p) == state) {
        return std::get<1>(p);
      }
    }
    throw std::runtime_error("Error: state not found in failure map.");
  }

  int fail_prime(int state) {
    if (state == 1)
      return 0;
    else
      return failure_func(state);
  }

  int goto_func(int state, char symbol) {
    for (auto &e : goto_map) {
      if (e.source == state && e.label == symbol) {
        return e.destination;
      }
    }
    return FAIL;
  }

  int next_move(int state, char symbol) {
    for (auto &e : next_move_map) {
      if (e.source == state && e.label == symbol) {
        return e.destination;
      }
    }
    return FAIL;
  }

public:
  void initialize_state(vector<string> dictionary) {
    int newstate {0};
    auto enter = [&newstate, this](string keyword) {
      int state {0};
      size_t j {0};
      while (goto_func(state, keyword.at(j)) != FAIL) {
        state = goto_func(state, keyword.at(j));
        ++j;
      }
      for (auto p {j}; p < keyword.length(); ++p) {
        ++newstate;
        goto_map.push_back({state, newstate, keyword.at(p)});
        state = newstate;
      }

      if (output(state).empty()) {
        output_map.push_back({state, vector<string> {keyword}});
      } else {
        output(state).push_back(keyword);
      }
    };

    for (auto &keyword : dictionary) {
      enter(keyword);
    }

    for (auto &a : alphabet) {
      if (goto_func(0, a) == FAIL) {
        goto_map.push_back({0, 0, a});
      }
    }
  }

  void initialize_failure() {
    std::queue<int> q {};
    for (auto &a : alphabet) {
      int s {goto_func(0, a)};
      if (s != FAIL && s != 0) {
        q.push(s);
        fail_map.push_back({s, 0});
      }
    }

    while (!q.empty()) {
      int r {q.front()};
      q.pop();

      for (auto &a : alphabet) {
        int s {goto_func(r, a)};
        if (s != FAIL) {
          q.push(s);
          int state {failure_func(r)};

          while (goto_func(state, a) == FAIL) {
            state = failure_func(state);
          }

          fail_map.push_back({s, goto_func(state, a)});
          int fs {failure_func(s)};
          auto out_fs = output(fs);
          if (output(s).empty()) {
            output_map.push_back({fs, out_fs});
          } else {
            for (auto &keyword : out_fs) {
              output(s).push_back(keyword);
            }
          }
        }
      }
    }
  }

  void initialize_next_move() {
    std::queue<int> q {};
    for (auto &a : alphabet) {
      int g {goto_func(0, a)};
      next_move_map.push_back({0, g, a});
      if (g != 0) {
        q.push(g);
      }
    }

    while (!q.empty()) {
      int r {q.front()};
      q.pop();
      for (auto &a : alphabet) {
        int s = goto_func(r, a);
        if (s != FAIL) {
          q.push(s);
          next_move_map.push_back({r, s, a});
        } else {
          next_move_map.push_back({r, next_move(failure_func(r), a), a});
        }
      }
    }
  }

  vector<tuple<size_t, string>> pattern_matching_machine(string input) {
    vector<tuple<size_t, string>> matches {};
    int state {0};
    for (size_t i {0}; i < input.length(); ++i) {
      state = next_move(state, input.at(i));

      auto out {output(state)};
      if (!out.empty()) {
        for (auto &keyword : out) {
          matches.push_back({i, keyword});
        }
      }
    }
    return matches;
  }
};

int part_two(string line, machine *matcher);

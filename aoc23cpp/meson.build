project('aoc23cpp', 'cpp',
  version : '0.1',
  default_options : ['cpp_std=c++17', 'warning_level=2'])


day1_header = library('day1h', 'day1.h')
executable('day1',
           'day1.cpp',
           link_with: day1_header,
           install : true)

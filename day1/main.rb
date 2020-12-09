numbers = File.open("day1/input")
  .readlines
  .map(&:chomp!)
  .map(&:to_i)

pair = numbers.combination(2).find { |pair| pair.sum == 2020 }
puts pair.reduce(1, :*)

triple = numbers.combination(3).find { |triple| triple.sum == 2020 }
puts triple.reduce(1, :*)

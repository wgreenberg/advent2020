numbers = File.open("day1/input")
  .readlines
  .map(&:chomp!)
  .map(&:to_i)

pair = numbers.combination(2).select { |pair| pair.sum == 2020 }.first
puts pair.reduce(1, :*)

triple = numbers.combination(3).select { |triple| triple.sum == 2020 }.first
puts triple.reduce(1, :*)

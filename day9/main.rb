numbers = File.open("day9/input")
  .readlines(chomp: true)
  .map(&:to_i)

# returns nil if valid, and the first invalid number if not
def validate_xmas(numbers, preamble_size)
  numbers.each_cons(preamble_size + 1)
    .map { |window| [window.first(preamble_size), window.last] }
    .filter { |preamble, n| !preamble.combination(2).map(&:sum).member? n }
    .map(&:last)
    .first
end

puts validate_xmas(numbers, 25)

def find_summation_group(numbers, n)
  ranges = (0..numbers.length - 1).map do |start|
    stop = (start..numbers.length).find { |stop| numbers[start..stop].sum >= n }
    [start, stop]
  end

  ranges.map { |start, stop| numbers[start..stop] }
    .find { |group| group.sum == n }
end

group = find_summation_group(numbers, validate_xmas(numbers, 25))
puts group.max + group.min

groups = File.open("day6/input")
  .read
  .split("\n\n")
  .map { |s| s.split("\n").map(&:chars) }

puts groups.map { |group| group.join.chars.uniq.length }.sum

puts groups.map { |group| group.reduce(('a'..'z').to_a, :intersection) }
  .map(&:length)
  .sum

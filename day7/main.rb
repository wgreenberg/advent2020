rules = File.open("day7/input")
  .readlines(chomp: true)
  .map { |line| line.gsub(/\sbags?/, "").split(" contain ") }
  .map { |lhs, rhs| [lhs, rhs.delete_suffix(".").split(", ").filter { |v| v != "no other" }] }
  .map { |lhs, rhs| [lhs, rhs.map { |rule| [rule.to_i, rule.split.drop(1).join(" ")] }]}
  .to_h

def reverse_search(data, color)
  data.select { |parent, children| children.any? { |n, c| c == color }}.keys
    .map { |parent| reverse_search(data, parent).push(parent) }
    .flatten
    .uniq
end

puts reverse_search(rules, "shiny gold").length

def total_bags(data, color)
  data[color].map { |n, c| n * (1 + total_bags(data, c)) }.sum
end

puts total_bags(rules, "shiny gold")

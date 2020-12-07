rules = File.open("day7/input")
  .readlines(chomp: true)
  .map { |line| line.gsub(/\sbags?/, "").split(" contain ") }
  # turns rules like "1 x, 7 y" into [[1, "x"], [7, "y"]]
  .map do |bag, rhs|
    rule = rhs.delete_suffix(".").split(", ")
      .filter { |v| v != "no other" }
      .map { |rule| [rule.to_i, rule.split.drop(1).join(" ")] }
    [bag, rule]
  end.to_h

def reverse_search(data, search_color)
  data.select { |parent, children| children.any? { |n, color| color == search_color }}
    .keys.map { |parent| reverse_search(data, parent).push(parent) }
    .flatten
    .uniq
end

puts reverse_search(rules, "shiny gold").length

def total_bags(data, search_color)
  data[search_color].map { |n, color| n * (1 + total_bags(data, color)) }.sum
end

puts total_bags(rules, "shiny gold")

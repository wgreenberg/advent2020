class Treeline
  def initialize(line)
    @line = line
  end

  def is_tree(idx)
    @line[idx % @line.length] == "#"
  end
end

data = File.open("day3/input")
  .readlines
  .map(&:chomp!)
  .map { |line| Treeline.new line }

def count_trees(lines, n_over, n_down)
  lines.each_with_index
    .filter { |line, idx| idx % n_down == 0 && line.is_tree((idx * n_over)/n_down) }.length
end

puts count_trees(data, 3, 1)
puts [
  count_trees(data, 1, 1),
  count_trees(data, 3, 1),
  count_trees(data, 5, 1),
  count_trees(data, 7, 1),
  count_trees(data, 1, 2),
].reduce(1, :*)

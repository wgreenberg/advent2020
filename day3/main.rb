class Treeline
  def initialize(line)
    @line = line
  end

  def is_tree(idx)
    @line[idx % @line.length] == "#"
  end
end

treelines = File.open("day3/input")
  .readlines
  .map(&:chomp!)
  .map { |line| Treeline.new line }

def count_trees(lines, n_over, n_down)
  lines.each_with_index
    .filter { |line, idx| idx % n_down == 0 } # skip every n_down lines
    .count { |line, idx| line.is_tree((idx * n_over)/n_down) }
end

puts count_trees(treelines, 3, 1)
puts [
  count_trees(treelines, 1, 1),
  count_trees(treelines, 3, 1),
  count_trees(treelines, 5, 1),
  count_trees(treelines, 7, 1),
  count_trees(treelines, 1, 2),
].reduce(1, :*)

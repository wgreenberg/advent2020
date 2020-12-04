data = File.open("day2/input")
  .readlines
  .map { |line| line.split(": ") }

def is_valid_pt1(rule, password)
  range, char = rule.split
  lower_bound, upper_bound = range.split("-").map(&:to_i)
  count = password.count(char)
  if lower_bound <= count && count <= upper_bound
    return password
  end
end

test_data = [
  ["1-3 a", "abcde"],
  ["1-3 b", "cdefg"],
  ["2-9 c", "ccccccccc"],
]

raise "pt1 example fail" unless test_data
  .filter { |rule, password| is_valid_pt1(rule, password) }
  .map { |parts| parts[1] } == ["abcde", "ccccccccc"]

puts data.count { |rule, password| is_valid_pt1(rule, password) }

def is_valid_pt2(rule, password)
  range, char = rule.split
  pos1, pos2 = range.split("-").map(&:to_i)
  if (password[pos1 - 1] == char) ^ (password[pos2 - 1] == char)
    return password
  end
end

raise "pt2 example fail" unless test_data
  .filter_map { |rule, password| is_valid_pt2(rule, password) } == ["abcde"]

puts data.count { |rule, password| is_valid_pt2(rule, password) }

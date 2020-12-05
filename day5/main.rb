require 'set'

class Array
  def front
    self.slice(0, self.length/2)
  end

  def back
    self.slice(self.length/2, self.length)
  end
end

def find_seat(pattern)
  front_back = { "F" => :front, "B" => :back }
  left_right = { "L" => :front, "R" => :back }

  row = pattern.chars
    .filter_map { |letter| front_back[letter] }
    .reduce((0..127).to_a) { |rows, dir| rows.send(dir) }
  column = pattern.chars
    .filter_map { |letter| left_right[letter] }
    .reduce((0..7).to_a) { |rows, dir| rows.send(dir) }
  [row.first, column.first]
end

raise "example fail" unless find_seat("FBFBBFFRLR") == [44, 5]
raise "example fail" unless find_seat("BFFFBBFRRR") == [70, 7]
raise "example fail" unless find_seat("FFFBBBFRRR") == [14, 7]
raise "example fail" unless find_seat("BBFFBBFRLL") == [102, 4]

seat_ids = File.open("day5/input")
  .readlines(chomp: true)
  .map { |pattern| find_seat(pattern) }
  .map { |row, col| row * 8 + col }

puts seat_ids.max

min_row = seat_ids.min / 8
max_row= seat_ids.max / 8

all_seats = (min_row..max_row-1).to_a.product((0..7).to_a)
  .map { |row, col| row * 8 + col }
  .to_set
possible_seats = seat_ids
  .filter { |id| id.between?(min_row * 8, max_row * 8 - 1) }
  .to_set
puts (all_seats - possible_seats).first

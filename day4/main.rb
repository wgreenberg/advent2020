class Array
  def has_required_fields?
    ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? do |req_field|
      self.map(&:first).include? req_field
    end
  end

  def has_valid_fields?
    self.all? do |field, value|
      next value.to_i.between?(1920, 2002) if field == "byr"
      next value.to_i.between?(2010, 2020) if field == "iyr"
      next value.to_i.between?(2020, 2030) if field == "eyr"
      next value.to_i.between?(150, 193) if field == "hgt" && value.end_with?("cm")
      next value.to_i.between?(59, 76) if field == "hgt" && value.end_with?("in")
      next /#[a-f0-9]{6}/.match? value if field == "hcl"
      next ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].include? value if field == "ecl"
      next value.length == 9 && value.to_i != 0 if field == "pid"
      next true if field == "cid"
      false
    end
  end
end

class String
  def into_passports
    self.split("\n\n")
      .map(&:split)
      .map { |passport| passport.map { |parts| parts.split(":") }}
  end
end

puts File.open("day4/input").read
  .into_passports
  .count(&:has_required_fields?)

raise "failed invalid" unless File.open("day4/invalid").read
  .into_passports
  .filter(&:has_required_fields?)
  .count(&:has_valid_fields?) == 0

raise "failed valid" unless File.open("day4/valid").read
  .into_passports
  .filter(&:has_required_fields?)
  .count(&:has_valid_fields?) == 4

puts File.open("day4/input").read
  .into_passports
  .filter(&:has_required_fields?)
  .count(&:has_valid_fields?)

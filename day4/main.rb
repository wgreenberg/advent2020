def has_valid_fields(passport)
  ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"].all? do |req_field|
    passport.map(&:first).include? req_field
  end
end

def into_passports(input)
  input.split("\n\n")
    .map(&:split)
    .map { |passport| passport.map { |parts| parts.split(":") }}
end

puts into_passports(File.open("day4/input").read)
  .count { |passport| has_valid_fields(passport) }

def validate_passport_fields(passport)
  passport.all? do |field, value|
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

raise "failed invalid" unless into_passports(File.open("day4/invalid").read)
  .filter { |passport| has_valid_fields(passport) }
  .count { |passport| validate_passport_fields(passport) } == 0

raise "failed valid" unless into_passports(File.open("day4/valid").read)
  .filter { |passport| has_valid_fields(passport) }
  .count { |passport| validate_passport_fields(passport) } == 4

puts into_passports(File.open("day4/input").read)
  .filter { |passport| has_valid_fields(passport) }
  .count { |passport| validate_passport_fields(passport) }

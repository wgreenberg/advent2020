class Program
  attr_accessor :acc

  def initialize(instructions)
    @acc = @pc = 0
    @instructions = instructions
    @visited = []
  end

  def has_looped?
    @visited.member? @pc
  end

  def has_terminated?
    @pc == @instructions.length || has_looped?
  end

  def step
    op, arg = @instructions[@pc]
    @visited.push(@pc)
    @acc += arg if op == "acc"
    @pc += arg if op == "jmp"
    @pc += 1 if op != "jmp"
  end

  def run
    self.step until self.has_terminated?
    !self.has_looped?
  end
end

instructions = File.open("day8/input")
  .readlines(chomp: true)
  .map(&:split)
  .map { |inst, val| [inst, val.to_i] }

program = Program.new instructions
program.run
puts program.acc

fixed_program = instructions.each_with_index
  .filter { |instruction, idx| ["jmp", "nop"].member? instruction.first }
  .map do |instruction, idx|
    op, arg = instruction
    tweaked = instructions.clone
    tweaked[idx] = [op == "jmp" ? "nop" : "jmp", arg]
    Program.new tweaked
  end
  .find(&:run)
puts fixed_program.acc

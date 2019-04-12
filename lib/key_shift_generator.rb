require_relative 'shift_generator'

class KeyShiftGenerator < ShiftGenerator
  attr_reader :key

  def initialize(key)
    @key = ('%5s' % key.to_s).gsub(" ", "0")
  end

  def shift_array
    key_shifts = []
    @key.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end
end

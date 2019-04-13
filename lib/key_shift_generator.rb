require_relative 'shift_generator'

class KeyShiftGenerator < ShiftGenerator
  def initialize(key_input)
    super(key_input)
    @key_length = SHIFT_COUNT + 1
  end

  def shift_array
    key_shifts = []
    validate_key_input.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end
end

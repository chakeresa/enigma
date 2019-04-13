require_relative 'shift_generator'

class DateShiftGenerator < ShiftGenerator

  def initialize(key_input)
    super(key_input)
    @key_length = 6
  end

  def shift_array
    key_squared = validate_key_input.to_i ** 2
    last_digits = key_squared.to_s[(-1 * SHIFT_COUNT)..-1]
    last_digits.chars.map {|character| character.to_i}
  end
end

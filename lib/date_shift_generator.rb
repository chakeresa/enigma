require_relative 'shift_generator'

class DateShiftGenerator < ShiftGenerator
  KEY_LENGTH = 6

  def shift_array
    key_squared = @key.to_i ** 2
    last_digits = key_squared.to_s[(-1 * SHIFT_COUNT)..-1]
    last_digits.chars.map {|character| character.to_i}
  end
end

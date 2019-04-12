require_relative 'shift_generator'

class DateShiftGenerator < ShiftGenerator
  attr_reader :date_key

  def initialize(date_key)
    @date_key = date_key
  end

  def shift_array
    date_key_squared = @date_key.to_i ** 2
    last_digits = date_key_squared.to_s[(-1 * SHIFT_COUNT)..-1]
    last_digits.chars.map {|character| character.to_i}
  end
end

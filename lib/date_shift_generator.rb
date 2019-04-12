require_relative 'shift_generator'

class DateShiftGenerator < ShiftGenerator
  attr_reader :date_key

  def initialize(date_key)
    @date_key = date_key
  end

  def shift_array
    date_key_squared = @date_key.to_i ** 2
    last_four_digits = date_key_squared.to_s[-4..-1]
    last_four_digits.chars.map {|character| character.to_i}
  end

  # TO DO: consider creating a ShiftGenerator superclass that will do this for both KeyShiftGenerator and DateShiftGenerator
  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

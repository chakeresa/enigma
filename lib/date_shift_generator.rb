require_relative 'shift_generator'

class DateShiftGenerator < ShiftGenerator
  # TO DO: consider making date_key an argument of date_shift_array *class* method
  # OR: run date_shift_array in init so its result can be stored

  attr_reader :date_key

  def initialize(date_key)
    @date_key = date_key
  end

  def date_shift_array
    date_key_squared = @date_key.to_i ** 2
    last_four_digits = date_key_squared.to_s[-4..-1]
    last_four_digits.chars.map {|character| character.to_i}
  end

  # TO DO: consider creating a ShiftGenerator superclass that will do this for both KeyShiftGenerator and DateShiftGenerator
  def neg_date_shift_array
    date_shift_array.map {|shift| -1 * shift}
  end
end

class DateShiftGenerator
  attr_reader :date_key

  def initialize(date_key)
    @date_key = date_key
  end

  def date_shift_array
    date_key_squared = @date_key.to_i ** 2
    last_four_digits = date_key_squared.to_s[-4..-1]
    last_four_digits.chars.map {|character| character.to_i}
  end
end

class KeyShiftGenerator
  # TO DO: consider making key an argument of key_shift_array *class* method
  # OR: run key_shift_array in init so its result can be stored

  attr_reader :key

  def initialize(key)
    @key = ('%5s' % key.to_s).gsub(" ", "0")
  end

  def key_shift_array
    key_shifts = []
    @key.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end

  # TO DO: consider creating a ShiftGenerator superclass that will do this for both KeyShiftGenerator and DateShiftGenerator
  def neg_key_shift_array
    key_shift_array.map {|shift| -1 * shift}
  end
end

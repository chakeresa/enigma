class KeyShiftGenerator
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def key_shift_array
    key_shifts = []
    @key.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end
end

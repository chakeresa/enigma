require_relative 'shift_generator'

class KeyShiftGenerator < ShiftGenerator
  KEY_LENGTH = SHIFT_COUNT + 1
  # TO DO: ^ change key_length to an ivar (in ShiftGenerator & DateShiftGenerator too). Also stop validating key input in initialize.

  def shift_array
    key_shifts = []
    @key.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end
end

require_relative 'shift_generator'

class KeyShiftGenerator < ShiftGenerator
  attr_reader :key_length,
              :key

  def initialize(key_input)
    @key_length = SHIFT_COUNT + 1
    @key = validate_key_input(key_input)
  end

  def validate_key_input(key_input)
    all_numerical = key_input.to_s.scan(/\d/).length == key_input.to_s.length
    if !all_numerical || key_input.to_s.length > @key_length
      # TO DO: throw error (should be numerical & less than key_length digits)
    else
      ('%5s' % key_input.to_s).gsub(" ", "0")
      # TO DO: ^ figure out how to change 5 to SHIFT_COUNT + 1
    end
  end

  def shift_array
    key_shifts = []
    @key.chars.each_cons(2) do |number1, number2|
      key_shifts << (number1 + number2).to_i
    end
    key_shifts
  end
end

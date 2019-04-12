class ShiftGenerator
  SHIFT_COUNT = 4
  KEY_LENGTH = 7

  attr_reader :key

  def initialize(key_input)
    @key = validate_key_input(key_input)
  end

  def validate_key_input(key_input)
    all_numerical = key_input.to_s.scan(/\d/).length == key_input.to_s.length
    if !all_numerical || key_input.to_s.length > KEY_LENGTH
      # TO DO: throw error (should be numerical & less than KEY_LENGTH digits)
    else
      ('%5s' % key_input.to_s).gsub(" ", "0")
      # TO DO: ^ figure out how to change 5 to KEY_LENGTH
    end
  end

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

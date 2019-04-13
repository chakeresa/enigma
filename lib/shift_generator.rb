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
      format = '%' + '5' + 's'
      # format = '%' + KEY_LENGTH.to_s + 's'
      # TO DO: ^ uncomment & deal with fallout from this change -- may need KEY_LENGTH constant (should pull from subclass not ShiftGenerator itself)
      (format % key_input.to_s).gsub(" ", "0")
    end
  end

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

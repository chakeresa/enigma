class ShiftGenerator
  SHIFT_COUNT = 4

  attr_reader :key_input, :key_length, :formatted_key

  def initialize(key_input)
    @key_input = key_input
    @key_length = 7
  end

  def validate_key_input
    all_numerical = @key_input.to_s.scan(/\d/).length == @key_input.to_s.length
    if !all_numerical || @key_input.to_s.length > @key_length
      raise "Key input should be numerical and #{@key_length} digits at most."
    else
      # format = '%' + '5' + 's'
      format = '%' + @key_length.to_s + 's'
      # TO DO: ^ uncomment & deal with fallout from this change -- may need @key_length constant (should pull from subclass not ShiftGenerator itself)
      @formatted_key = (format % @key_input.to_s).gsub(" ", "0")
    end
  end

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

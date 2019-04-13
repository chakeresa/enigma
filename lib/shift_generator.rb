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
      @formatted_key = (format % @key_input.to_s).gsub(" ", "0")
    end
  end

  def format
    '%' + @key_length.to_s + 's'
  end

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

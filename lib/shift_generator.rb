class ShiftGenerator
  attr_reader :shift_count
  
  def initialize(shift_count = 4)
    @shift_count = shift_count
  end

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

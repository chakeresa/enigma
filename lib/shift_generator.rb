class ShiftGenerator
  SHIFT_COUNT = 4

  def neg_shift_array
    shift_array.map {|shift| -1 * shift}
  end
end

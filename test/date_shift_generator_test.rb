require './test/test_helper'

class DateShiftGeneratorTest < Minitest::Test
  def setup
    @date_shift_gen1 = DateShiftGenerator.new("011218")
  end

  def test_it_exists
    assert_instance_of DateShiftGenerator, @date_shift_gen1
  end

  def test_it_inits_with_a_date_key_string
    assert_equal "011218", @date_shift_gen1.date_key
  end

  def test_shift_array_returns_array_of_abcd_offsets
    assert_equal [3, 5, 2, 4], @date_shift_gen1.shift_array
  end

  def test_neg_shift_array_returns_negatives_of_shift_array
    assert_equal [-3, -5, -2, -4], @date_shift_gen1.neg_shift_array
  end
end

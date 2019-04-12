require './test/test_helper'

class DateShiftGeneratorTest < Minitest::Test
  def setup
    @date_shift_gen1 = DateShiftGenerator.new("011218")
  end

  def test_it_exists
    assert_instance_of DateShiftGenerator, @date_shift_gen1
  end

  def test_it_has_a_key_length_constant
    assert_equal 6, DateShiftGenerator::KEY_LENGTH
  end

  def test_init_adds_padding_to_key_input
    skip
    # TO DO: fix ShiftGenerator#validate_key_input so it pads to KEY_LENGTH instead of hard-entered 5
    assert_equal "011419", DateShiftGenerator.new(11419).key
    assert_equal "011419", DateShiftGenerator.new("11419").key
  end

  def test_init_throws_error_if_key_input_too_long_or_non_numerical
    skip
    assert_equal # TO DO: throw error, DateShiftGenerator.new("12042019").key
    assert_equal # TO DO: throw error, DateShiftGenerator.new("apr11").key
  end

  def test_it_inits_with_a_date_key_string
    assert_equal "011218", @date_shift_gen1.key
  end

  def test_shift_array_returns_array_of_abcd_offsets
    assert_equal [3, 5, 2, 4], @date_shift_gen1.shift_array
  end

  def test_neg_shift_array_returns_negatives_of_shift_array
    assert_equal [-3, -5, -2, -4], @date_shift_gen1.neg_shift_array
  end
end

require './test/test_helper'

class DateShiftGeneratorTest < Minitest::Test
  def setup
    @date_shift_gen1 = DateShiftGenerator.new("011218")
  end

  def test_it_exists
    assert_instance_of DateShiftGenerator, @date_shift_gen1
  end

  def test_it_inits_with_a_key_input
    assert_equal "011218", @date_shift_gen1.key_input

    invalid_input = DateShiftGenerator.new("9999999999")
    assert_equal "9999999999", invalid_input.key_input
  end

  def test_it_has_a_key_length_of_6
    assert_equal 6, @date_shift_gen1.key_length
  end

  def test_it_inits_with_no_formatted_key
    assert_nil @date_shift_gen1.formatted_key
  end

  def test_validate_key_input_adds_padding_to_key_input
    integer_input = DateShiftGenerator.new(11419)
    assert_equal "011419", integer_input.validate_key_input
    assert_equal "011419", integer_input.formatted_key

    string_input = DateShiftGenerator.new("11419")
    assert_equal "011419", string_input.validate_key_input
    assert_equal "011419", string_input.formatted_key
  end

  def test_validate_key_input_throws_error_if_key_input_too_long_or_non_numerical
    error_message = "Key input should be numerical and 6 digits at most."
    err1 = assert_raises(RuntimeError) do
      DateShiftGenerator.new("12042019").validate_key_input
    end
    assert_equal error_message, err1.message
    err2 = assert_raises(RuntimeError) do
      DateShiftGenerator.new("apr11").validate_key_input
    end
    assert_equal error_message, err2.message
  end

  def test_shift_array_returns_array_of_abcd_offsets
    assert_equal [3, 5, 2, 4], @date_shift_gen1.shift_array
  end

  def test_neg_shift_array_returns_negatives_of_shift_array
    assert_equal [-3, -5, -2, -4], @date_shift_gen1.neg_shift_array
  end
end

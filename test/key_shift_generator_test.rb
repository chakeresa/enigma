require './test/test_helper'

class KeyShiftGeneratorTest < Minitest::Test
  def setup
    @key_shift_gen1 = KeyShiftGenerator.new("58467")
  end

  def test_it_exists
    assert_instance_of KeyShiftGenerator, @key_shift_gen1
  end

  def test_it_inits_with_a_key_input
    assert_equal "58467", @key_shift_gen1.key_input
  end

  def test_it_has_a_key_length_of_5
    assert_equal 5, @key_shift_gen1.key_length
  end

  def test_it_inits_with_no_formatted_key
    assert_nil @key_shift_gen1.formatted_key
  end

  def test_init_adds_padding_to_key_input
    integer_input = KeyShiftGenerator.new(476)
    assert_equal "00476", integer_input.validate_key_input
    assert_equal "00476", integer_input.formatted_key

    string_input = KeyShiftGenerator.new(476)
    assert_equal "00476", string_input.validate_key_input
    assert_equal "00476", string_input.formatted_key
  end

  def test_init_throws_error_if_key_input_too_long_or_non_numerical
    error_message = "Key input should be numerical and 5 digits at most."
    err1 = assert_raises(RuntimeError) do
      KeyShiftGenerator.new("548138").validate_key_input
    end
    assert_equal error_message, err1.message
    err2 = assert_raises(RuntimeError) do
      KeyShiftGenerator.new("hi7").validate_key_input
    end
    assert_equal error_message, err2.message
  end

  def test_key_is_a_string_with_leading_zeroes_even_if_fed_integer
    key_shift_gen4 = KeyShiftGenerator.new(705)
    assert_equal "00705", key_shift_gen4.validate_key_input
    assert_equal "00705", key_shift_gen4.formatted_key
  end

  def test_shift_array_returns_array_of_abcd_keys
    assert_equal [58, 84, 46, 67], @key_shift_gen1.shift_array
  end

  def test_shift_array_works_w_leading_zeroes_in_key
    key_shift_gen2 = KeyShiftGenerator.new("00287")
    assert_equal [0, 2, 28, 87], key_shift_gen2.shift_array
  end

  def test_shift_array_works_zeroes_in_middle_of_key
    key_shift_gen3 = KeyShiftGenerator.new("50763")
    assert_equal [50, 7, 76, 63], key_shift_gen3.shift_array
  end

  def test_neg_shift_array_returns_negatives_of_shift_array
    assert_equal [-58, -84, -46, -67], @key_shift_gen1.neg_shift_array
  end
end

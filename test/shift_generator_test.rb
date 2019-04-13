require './test/test_helper'

class ShiftGeneratorTest < Minitest::Test
  def setup
    @shift_gen1 = ShiftGenerator.new(42)
  end

  def test_it_exists
    assert_instance_of ShiftGenerator, @shift_gen1
  end

  def test_it_has_shift_count_const_equal_to_four
    assert_equal 4, ShiftGenerator::SHIFT_COUNT
  end

  def test_it_has_dummy_key_length_attr_equal_to_seven
    assert_equal 7, @shift_gen1.key_length
  end

  def test_it_has_key_input_upon_init
    assert_equal 42, @shift_gen1.key_input
  end

  def test_validate_key_input_returns_padded_key_if_valid
    assert_equal "0000042", @shift_gen1.validate_key_input
    assert_equal "0000042", @shift_gen1.formatted_key
  end

  def test_validate_key_input_throws_error_if_key_input_too_long_or_nonnumerical
    error_message = "Key input should be numerical and 7 digits at most."
    err1 = assert_raises(RuntimeError) do
      ShiftGenerator.new("478884546").validate_key_input
    end
    assert_equal error_message, err1.message
    err2 = assert_raises(RuntimeError) do
      ShiftGenerator.new("hi7").validate_key_input
    end
    assert_equal error_message, err2.message
  end
end

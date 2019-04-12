require './test/test_helper'

class KeyShiftGeneratorTest < Minitest::Test
  def setup
    @key_shift_gen1 = KeyShiftGenerator.new("58467")
  end

  def test_it_exists
    assert_instance_of KeyShiftGenerator, @key_shift_gen1
  end

  def test_it_inits_with_a_key
    assert_equal "58467", @key_shift_gen1.key
  end

  def test_key_shift_array_returns_array_of_abcd_keys
    assert_equal [58, 84, 46, 67], @key_shift_gen1.key_shift_array
  end

  def test_key_shift_array_works_w_leading_zeroes_in_key
    key_shift_gen2 = KeyShiftGenerator.new("00287")
    assert_equal [0, 2, 28, 87], key_shift_gen2.key_shift_array
  end

  def test_key_shift_array_works_zeroes_in_middle_of_key
    key_shift_gen3 = KeyShiftGenerator.new("50763")
    assert_equal [50, 7, 76, 63], key_shift_gen3.key_shift_array
  end
end

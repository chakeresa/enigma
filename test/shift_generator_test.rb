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

  def test_it_has_dummy_key_length_const_equal_to_seven
    assert_equal 7, ShiftGenerator::KEY_LENGTH
  end
end

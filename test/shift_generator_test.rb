require './test/test_helper'

class ShiftGeneratorTest < Minitest::Test
  def setup
    @shift_gen1 = ShiftGenerator.new
  end

  def test_it_exists
    assert_instance_of ShiftGenerator, @shift_gen1
  end

  def test_it_has_shift_count_const_equal_to_four
    assert_equal 4, ShiftGenerator::SHIFT_COUNT
  end
end

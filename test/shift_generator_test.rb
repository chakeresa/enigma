require './test/test_helper'

class ShiftGeneratorTest < Minitest::Test
  def setup
    @shift_gen4 = ShiftGenerator.new
    @shift_gen7 = ShiftGenerator.new(7)
  end

  def test_it_exists
    assert_instance_of ShiftGenerator, @shift_gen4
  end

  def test_it_has_shift_count_attr_that_defaults_to_four
    assert_equal 4, @shift_gen4.shift_count
    assert_equal 7, @shift_gen7.shift_count
  end
end

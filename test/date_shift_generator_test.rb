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
end

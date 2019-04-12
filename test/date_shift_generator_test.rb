require './test/test_helper'

class DateShiftGeneratorTest < Minitest::Test
  def setup
    @date_shift_gen1 = DateShiftGenerator.new
  end

  def test_it_exists
    assert_instance_of DateShiftGenerator, @date_shift_gen1
  end
end

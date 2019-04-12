require './test/test_helper'

class ShiftGeneratorTest < Minitest::Test
  def setup
    @shift_gen1 = ShiftGenerator.new
  end

  def test_it_exists
    assert_instance_of ShiftGenerator, @shift_gen1
  end
end

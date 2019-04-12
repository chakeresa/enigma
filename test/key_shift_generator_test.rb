require './test/test_helper'

class KeyShiftGeneratorTest < Minitest::Test
  def setup
    @key_shift_gen = KeyShiftGenerator.new
  end

  def test_it_exists
    assert_instance_of KeyShiftGenerator, @key_shift_gen
  end
end

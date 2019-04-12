require './test/test_helper'

class KeyShiftGeneratorTest < Minitest::Test
  def setup
    @key_shift_gen = KeyShiftGenerator.new("58467")
  end

  def test_it_exists
    assert_instance_of KeyShiftGenerator, @key_shift_gen
  end

  def test_it_inits_with_a_key
    assert_equal "58467", @key_shift_gen.key
  end
end

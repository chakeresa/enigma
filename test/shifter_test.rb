require './test/test_helper'

class ShifterTest < Minitest::Test
  def setup
    @shifter = Shifter.new
  end

  def test_it_exists
    assert_instance_of Shifter, @shifter
  end

  def test_it_inits_with_character_set_of_a_to_z_and_space
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    assert_equal expected, @shifter.character_set
  end
end

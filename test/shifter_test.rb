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

  def test_shifted_set_returns_rotated_character_set_given_shift
    expected = ["c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " ", "a", "b"]
    assert_equal expected, @shifter.shifted_set(2)
  end

  def test_shifted_set_goes_backwards_given_negative_shift
    expected = ["y", "z", " ", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x"]
    assert_equal expected, @shifter.shifted_set(-3)
  end

  def test_shift_letter_returns_new_letter_given_orig_lowercase_letter_and_shift
    assert_equal "f", @shifter.shift_letter("d", 2)
  end

  def test_shift_letter_returns_new_letter_given_orig_uppercase_letter_and_shift
    assert_equal "w", @shifter.shift_letter("Z", -3)
  end

  def test_shift_letter_returns_new_letter_given_orig_uppercase_letter_and_shift
    assert_equal "&", @shifter.shift_letter("&", 2)
  end
end

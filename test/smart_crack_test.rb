require './test/test_helper'

class SmartCrackTest < Minitest::Test
  def setup
    @smart_crack_default = SmartCrack.new("vjqtbeaweqihssi", "291018")
  end

  def test_it_exists
    assert_instance_of SmartCrack, @smart_crack_default
  end

  def test_it_inits_with_ciphertext_date_end_of_msg_and_shift_count
    assert_equal "vjqtbeaweqihssi", @smart_crack_default.ciphertext
    assert_equal "291018", @smart_crack_default.date
    assert_equal " end", @smart_crack_default.end_of_msg
    assert_equal 4, @smart_crack_default.shift_count
  end

  def test_last_four_chars_returns_date_shifted_last_four_characters
    # TO DO
    smart_crack_short = SmartCrack.new("hello", "291018")
    assert_equal "bjhi", smart_crack_short.last_four_chars
  end

  def test_smart_crack_gets_message_out
    expected = {
      decryption: "hello world end",
      key: "08304",
      date: "291018"
    }

    assert_equal expected, @smart_crack_default.smart_crack
  end

  def test_filter_all_possible_shifts_fw
    all_possible_shifts = [["08", "35", "62", "89"], ["02", "29", "56", "83"], ["03", "30", "57", "84"], ["04", "31", "58", "85"]]
    assert_equal [["08", "35", "62", "89"], ["29", "56", "83"], ["30"], ["04"]], @smart_crack_default.filter_all_possible_shifts_fw(all_possible_shifts)
  end

  def test_filter_all_possible_shifts_bw
    all_possible_shifts = [["08", "35", "62", "89"], ["29", "56", "83"], ["30"], ["04"]]
    assert_equal [["08"], ["83"], ["30"], ["04"]], @smart_crack_default.filter_all_possible_shifts_bw(all_possible_shifts)
  end

  def test_filter_all_possible_shifts_bw_simplified
    all_possible_shifts = [["01", "02"], ["10"], ["05"]]
    assert_equal [["01"], ["10"], ["05"]], @smart_crack_default.filter_all_possible_shifts_bw(all_possible_shifts)
  end

  def test_valid_next_shift_returns_true_if_valid_consecutive_shifts
    first_shift_ary = ["08", "35", "62", "89"]
    possible_next_shift = "29"
    impossible_next_shift = "02"
    assert_equal true, @smart_crack_default.valid_next_shift?(possible_next_shift, first_shift_ary)
    assert_equal false, @smart_crack_default.valid_next_shift?(impossible_next_shift, first_shift_ary)
  end

  def test_valid_prev_shift_returns_true_if_valid_consecutive_shifts
    next_shift_ary = ["08", "35", "62", "89"]
    possible_prev_shift = "80"
    impossible_prev_shift = "77"
    assert_equal true, @smart_crack_default.valid_prev_shift?(possible_prev_shift, next_shift_ary)
    assert_equal false, @smart_crack_default.valid_prev_shift?(impossible_prev_shift, next_shift_ary)
  end

  def test_filtered_shift_ary_fw_returns_only_shifts_which_match_prev_ary_last_digit
    first_shift_ary = ["08", "35", "62", "89"]
    next_shift_ary = ["02", "29", "56", "83"]
    assert_equal ["29", "56", "83"], @smart_crack_default.filtered_shift_ary_fw(first_shift_ary, next_shift_ary)
  end

  def test_filtered_shift_ary_bw_returns_only_shifts_which_match_next_ary_first_digit
    prev_shift_ary = ["08", "35", "62", "89"]
    next_shift_ary = ["02", "29", "56", "83"]
    assert_equal ["08", "35", "62"], @smart_crack_default.filtered_shift_ary_bw(prev_shift_ary, next_shift_ary)
  end
end

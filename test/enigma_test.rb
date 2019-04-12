require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
    dd = ('%2s' % Date.today.day.to_s).gsub(" ", "0")
    mm = ('%2s' % Date.today.month.to_s).gsub(" ", "0")
    yy = ('%2s' % Date.today.year.to_s[-2..-1]).gsub(" ", "0")
    @expected_date = dd + mm + yy
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_generate_random_key_returns_a_5_digit_string_with_leading_zeroes
    lots_of_random_keys = []
    10000.times {lots_of_random_keys << @enigma.random_key}

    all_five_digits = lots_of_random_keys.all? {|key| key.length == 5}
    small_numbers_start_w_zero = lots_of_random_keys.all? do |key|
      key.to_i < 10000 ? key[0] == "0" : true
    end

    assert_equal true, all_five_digits
    assert_equal true, small_numbers_start_w_zero
    assert_instance_of String, lots_of_random_keys[0]
  end

  def test_todays_date_returns_ddmmyy
    assert_equal 6, @enigma.todays_date.length
    assert_instance_of String, @enigma.todays_date
    assert_equal Date.today.day, @enigma.todays_date[0..1].to_i
    assert_equal Date.today.month, @enigma.todays_date[2..3].to_i

    yy = Date.today.year.to_s[-2..-1].to_i
    assert_equal yy, @enigma.todays_date[4..5].to_i
  end

  def test_encrypt_lowercase_and_spaces_only_returns_hash
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
  end

  def test_encrypt_makes_uppercase_become_lowercase
    encrypted = @enigma.encrypt("HELLO world", "02715", "040895")[:encryption]

    assert_equal "keder ohulw", encrypted
  end

  def test_encrypt_doesnt_change_special_characters
    encrypted = @enigma.encrypt("hello world!", "02715", "040895")[:encryption]
    assert_equal "keder ohulw!", encrypted
  end

  def test_encrypt_with_no_date_uses_todays_date
    short_encrypt_return = @enigma.encrypt("hello world", "02715")
    long_encrypt_return = @enigma.encrypt("hello world", "02715", @expected_date)

    assert_equal @expected_date, short_encrypt_return[:date]
    assert_equal long_encrypt_return, short_encrypt_return
  end

  def test_encrypt_with_no_optional_args_returns_hash
    skip
    # expected = ? # TO DO
    # assert_equal expected, @enigma.encrypt("hello world")
  end

  def test_decrypt_returns_hash
    skip
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.decrypt("keder ohulw", "02715", "040895")
    # Enigma#decrypt(ciphertext, key, date)
    # The decrypt method takes a ciphertext String and the Key used for encryption as arguments. The decrypt method can optionally take a date as the third argument. If no date is given, this method should use today’s date for decryption.
  end

  def test_decrypt_uses_todays_date_if_no_date_argument
    skip
    encrypted = @enigma.encrypt("hello world", "02715")
    decrypted = @enigma.decrypt(encrypted[:encryption], "02715")[:decryption]

    assert_equal "hello world", decrypted
  end
end

require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_generate_random_key_returns_a_5_digit_string_with_leading_zeroes
    lots_of_random_keys = []
    10000.times {lots_of_random_keys << @enigma.generate_random_key}

    all_five_digits = lots_of_random_keys.all? {|key| key.length == 5}
    small_numbers_start_w_zero = lots_of_random_keys.all? do |key|
      key.to_i < 10000 ? key[0] == "0" : true
    end

    assert_equal true, all_five_digits
    assert_equal true, small_numbers_start_w_zero
    assert_instance_of String, lots_of_random_keys[0]
  end

  def test_encrypt_lowercase_and_spaces_only_returns_hash
    skip
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }

    assert_equal expected, @enigma.encrypt("hello world", "02715", "040895")
    # The encrypt method takes a message String as an argument. It can optionally take a Key and Date as arguments to use for encryption. If the key is not included, generate a random key. If the date is not included, use today’s date.
  end

  def test_encrypt_makes_uppercase_become_lowercase
    skip
    encrypted = @enigma.encrypt("HELLO world", "040895", "02715")[:encryption]
    assert_equal "keder ohulw", encrypted
  end

  def test_encrypt_doesnt_change_special_characters
    skip
    encrypted = @enigma.encrypt("hello world!", "040895", "02715")[:encryption]
    assert_equal "keder ohulw!", encrypted
  end

  def test_encrypt_with_no_date_uses_todays_date
    skip
    # expected = ? # TO DO
    # assert_equal expected, @enigma.encrypt("hello world", "02715")
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

require './test/test_helper'

class EnigmaTest < Minitest::Test
  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
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
end

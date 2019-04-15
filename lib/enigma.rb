require 'date'
require_relative 'shifter'
require_relative 'key_shift_generator'
require_relative 'date_shift_generator'

class Enigma
  def random_key
    max_number = "9" * (ShiftGenerator::SHIFT_COUNT + 1)
    random_number_string = rand(max_number.to_i).to_s
    format = KeyShiftGenerator.new(0).format
    (format % random_number_string).gsub(" ", "0")
  end

  def todays_date
    Date.today.strftime("%d%m%y")
  end

  def translate(message, shift_ary)
    translation = ""
    message.each_char.with_index do |char, index_of_char|
      abcd_index = index_of_char % ShiftGenerator::SHIFT_COUNT
      translation << Shifter.shift_letter(char, shift_ary[abcd_index])
    end
    translation
  end

  def encrypt(message, key = random_key, date = todays_date)
    key_shift_ary = KeyShiftGenerator.new(key).shift_array
    date_shift_ary = DateShiftGenerator.new(date).shift_array
    shifted = translate(message, key_shift_ary)
    ciphertext = translate(shifted, date_shift_ary)
    pretty_keys = format_keys(key, date)
    {encryption: ciphertext, key: pretty_keys[:key], date: pretty_keys[:date]}
  end

  def decrypt(ciphertext, key, date = todays_date)
    key_shift_ary = KeyShiftGenerator.new(key).neg_shift_array
    date_shift_ary = DateShiftGenerator.new(date).neg_shift_array
    shifted = translate(ciphertext, key_shift_ary)
    message = translate(shifted, date_shift_ary)
    pretty_keys = format_keys(key, date)
    {decryption: message, key: pretty_keys[:key], date: pretty_keys[:date]}
  end

  def crack(ciphertext, date = todays_date)
    key_guess = 0
    decrypted = decrypt(ciphertext, key_guess, date)[:decryption]
    while decrypted[(-1 * ShiftGenerator::SHIFT_COUNT)..-1] != " end"
      decrypted = decrypt(ciphertext, key_guess, date)[:decryption]
      key_guess += 1
      raise "Message cannot be cracked." if key_guess == 10 ** key_length
    end
    decrypt(ciphertext, key_guess - 1, date)
  end

  def key_length
    KeyShiftGenerator.new(0).key_length
  end

  def format_keys(key_input, date_input)
    formatted_key = KeyShiftGenerator.new(key_input).validate_key_input
    formatted_date = DateShiftGenerator.new(date_input).validate_key_input
    {key: formatted_key, date: formatted_date}
  end
end

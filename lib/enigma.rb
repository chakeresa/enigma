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
    while decrypted[-4..-1] != " end"
      decrypted = decrypt(ciphertext, key_guess, date)[:decryption]
      key_guess += 1
      raise "Message cannot be cracked." if key_guess == 10 ** key_length
    end
    decrypt(ciphertext, key_guess - 1, date)
  end

  def smart_crack(ciphertext, date = todays_date)
    end_of_msg = " end"
    msg_length = ciphertext.length
    shift_count = ShiftGenerator::SHIFT_COUNT
    last_four_char_shift_indices = (0..(shift_count - 1)).to_a.rotate(msg_length % shift_count)
    date_shift_ary = DateShiftGenerator.new(date).neg_shift_array
    date_shifted_msg = translate(ciphertext, date_shift_ary)
    last_four_chars = date_shifted_msg[(-1 * shift_count)..-1]
    min_possible_shifts = []
    last_four_chars.chars.each.with_index do |char, char_index|
      shift_guess = 0
      while Shifter.shift_letter(char, -1 * shift_guess) != end_of_msg[char_index]
        shift_guess += 1
      end
      min_possible_shifts[char_index] = shift_guess
    end
    all_possible_shifts = min_possible_shifts.map do |possible_shift|
      all_shifts = [possible_shift]
      while all_shifts.last + 27 < 100
        all_shifts << all_shifts.last + 27
      end
      all_shifts.map {|shift| (shift + 1000).to_s[-2..-1]}
    end.rotate!
    filtered_options = []
    all_possible_shifts.each_cons(2) do |opt_ary_1, opt_ary_2|
      last_digits_1 = opt_ary_1.map do |possible_shift_1|
        possible_shift_1.chars.last
      end
      first_digits_2 = opt_ary_2.map do |possible_shift_2|
        possible_shift_2.chars.first
      end
      filtered_options << last_digits_1 & first_digits_2

    end
    require "pry"; binding.pry
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

Enigma.new.smart_crack("vjqtbeaweqihssi", "291018")
# key is actually 08304 -- shifts = [08, 83, 30, 04]
# all_possible_shifts = [[**8**, 35, 62, 89], [2, 29, 56, **83**], [3, **30**, 57, 84], [**4**, 31, 58, 85], ]

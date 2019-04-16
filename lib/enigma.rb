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
    end.rotate! # check if working right with different length msg

    # all_possible_shifts = filter_all_possible_shifts_fw(all_possible_shifts)
    #
    # require "pry"; binding.pry

    # refactor all below

    filtered_options = []
    all_possible_shifts.each_cons(2) do |opt_ary_1, opt_ary_2|
      last_digits_1 = opt_ary_1.map do |possible_shift_1|
        possible_shift_1.chars.last
      end
      first_digits_2 = opt_ary_2.map do |possible_shift_2|
        possible_shift_2.chars.first
      end
      overlap = last_digits_1 & first_digits_2
      filtered_options << overlap
    end

    key_shifts = []
    key_shifts[1] = all_possible_shifts[1].find_all do |shift1|
      filtered_options[0].include?(shift1.chars.first) && filtered_options[1].include?(shift1.chars.last)
    end
    key_shifts[2] = all_possible_shifts[2].find_all do |shift2|
      shift2.chars.first == key_shifts[1][0].chars.last && filtered_options[1].include?(shift2.chars.first) && filtered_options[2].include?(shift2.chars.last)
    end
    key_shifts[3] = all_possible_shifts[3].find_all do |shift3|
      shift3.chars.first == key_shifts[2][0].chars.last && filtered_options[2].include?(shift3.chars.first)
    end
    key_shifts[0] = all_possible_shifts[0].find_all do |shift0|
      shift0.chars.last == key_shifts[1][0].chars.first && filtered_options[0].include?(shift0.chars.last)
    end

    key = ""
    key_shifts.flatten.each.with_index do |shift, index|
      if index == 0
        key << shift
      else
        key << shift.chars.last
      end
    end
    decrypt(ciphertext, key, date)
  end

  def valid_next_shift?(possible_next_shift, first_shift_ary)
    first_shift_ary.any? do |first_shift_elem|
      first_shift_elem.chars.last == possible_next_shift.chars.first
    end
  end

  def filtered_shift_ary(first_shift_ary, next_shift_ary)
    next_shift_ary.find_all do |possible_next_shift|
      valid_next_shift?(possible_next_shift, first_shift_ary)
    end
  end

  def filter_all_possible_shifts_fw(all_possible_shifts)
    all_possible_shifts.each_cons(2) do |opt_ary_prev, opt_ary_next|
      index_of_next = all_possible_shifts.find_index(opt_ary_next)
      all_possible_shifts[index_of_next] = filtered_shift_ary(opt_ary_prev, opt_ary_next)
    end
    all_possible_shifts
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

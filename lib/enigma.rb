require 'date'
require_relative 'shifter'
require_relative 'key_shift_generator'
require_relative 'date_shift_generator'

class Enigma
  def random_key
    random_number_string = rand(99999).to_s
    ('%5s' % random_number_string).gsub(" ", "0")
  end

  def todays_date
    Date.today.strftime("%d%m%y")
  end

  def translate(message, key_shift_ary, date_shift_ary)
    translation = ""
    message.each_char.with_index do |char, index_of_char|
      abcd_index = index_of_char % ShiftGenerator::SHIFT_COUNT
      shifted = Shifter.shift_letter(char, key_shift_ary[abcd_index])
      translation << Shifter.shift_letter(shifted, date_shift_ary[abcd_index])
    end
    translation
  end

  def encrypt(message, key = random_key, date = todays_date)
    key_shift_ary = KeyShiftGenerator.new(key).shift_array
    date_shift_ary = DateShiftGenerator.new(date).shift_array
    ciphertext = translate(message, key_shift_ary, date_shift_ary)
    {encryption: ciphertext, key: key, date: date}
  end

  def decrypt(ciphertext, key, date = todays_date)
    key_shift_ary = KeyShiftGenerator.new(key).neg_shift_array
    date_shift_ary = DateShiftGenerator.new(date).neg_shift_array
    message = translate(ciphertext, key_shift_ary, date_shift_ary)
    {decryption: message, key: key, date: date}
  end
end

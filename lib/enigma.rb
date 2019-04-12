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

  def generate_ciphertext(message, key_shift_ary, date_shift_ary)
    ciphertext = ""
    message.each_char.with_index do |char, index_of_char|
      abcd_index = index_of_char % 4
      shifted = Shifter.shift_letter(char, key_shift_ary[abcd_index])
      ciphertext << Shifter.shift_letter(shifted, date_shift_ary[abcd_index])
    end
    ciphertext
  end

  def encrypt(message, key = random_key, date = todays_date)
    key_shift_ary = KeyShiftGenerator.new(key).key_shift_array
    date_shift_ary = DateShiftGenerator.new(date).date_shift_array
    ciphertext = generate_ciphertext(message, key_shift_ary, date_shift_ary)
    {encryption: ciphertext, key: key, date: date}
  end

# def decrypt(ciphertext, key, date)
#   # TO DO
#   {
#     decryption: message, # TO DO
#     key: key,
#     date: date
#   }
# end
end

require 'date'
require_relative 'shifter'
require_relative 'key_shift_generator'
require_relative 'date_shift_generator'

class Enigma
  def generate_random_key
    random_number_string = rand(99999).to_s
    ('%5s' % random_number_string).gsub(" ", "0")
  end

  def todays_date
    Date.today.strftime("%d%m%y")
  end

# def encrypt(message, key, date)
#   # TO DO
#   {
#     encryption: ciphertext, # TO DO
#     key: key,
#     date: date
#   }
# end

# def decrypt(ciphertext, key, date)
#   # TO DO
#   {
#     decryption: message, # TO DO
#     key: key,
#     date: date
#   }
# end
end

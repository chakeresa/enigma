# Command Line Interface
#
# Additionally, you should create a Runner file called decrypt.rb that takes four command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the decrypted message. The third is the key to be used for decryption. The fourth is the date to be used for decryption. In addition to writing the decrypted message to the file, your program should output to the screen the file it wrote to, the key used for decryption, and the date used for decryption.
#
# You should be able to use your CLI like this:
#
# $ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818
# Created 'decrypted.txt' with the key 82648 and date 240818
#
# See this Lesson Plan for more info about working with files. http://backend.turing.io/module1/lessons/working_with_files
#
# You do not have to test your command line interface

require './lib/enigma'

# Use the CLI like this: `ruby ./lib/decrypt.rb ./data/encrypted.txt ./data/decrypted.txt <key> <optional date>`

encrypted_filepath = ARGV[0]
encrypted_file = File.open(encrypted_filepath, "r")
encryption = encrypted_file.read

key = ARGV[2]
date = ARGV[3].nil? ? Enigma.new.todays_date : ARGV[3]
decrypt_hash = Enigma.new.decrypt(encryption, key, date)

decrypted_filepath = ARGV[1]
decrypted_file = File.open(decrypted_filepath, "w")
decrypted_file.write(decrypt_hash[:decryption])
decrypted_file.close

puts "Created '#{decrypted_filepath}' with the key #{decrypt_hash[:key]} and date #{decrypt_hash[:date]}"

# Cracking Interface
# Additionally, create a Runner file called crack.rb that takes three command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the cracked message. The third is the date to be used for cracking. In addition to writing the cracked message to the file, your program should output to the screen the file it wrote to, the key used for cracking, and the date used for cracking:
#
# $ ruby ./lib/encrypt.rb message.txt encrypted.txt
# Created 'encrypted.txt' with the key 82648 and date 240818
# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
# Created 'cracked.txt' with the cracked key 82648 and date 240818

require './lib/enigma'

# Use the CLI like this: `ruby ./lib/crack.rb ./data/encrypted.txt ./data/cracked.txt <optional date>`

encrypted_filepath = ARGV[0]
encrypted_file = File.open(encrypted_filepath, "r")
encryption = encrypted_file.read.chomp

date = ARGV[2].nil? ? Enigma.new.todays_date : ARGV[2]
# TO DO: make sure works after crack is fixed (for todays_date case)
crack_hash = Enigma.new.crack(encryption, date)

cracked_filepath = ARGV[1]
cracked_file = File.open(cracked_filepath, "w")
cracked_file.write(crack_hash[:decryption])
cracked_file.close

puts "Created '#{cracked_filepath}' with the cracked key #{crack_hash[:key]} and date #{crack_hash[:date]}"

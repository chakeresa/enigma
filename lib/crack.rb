require './lib/enigma'

# Use the CLI like this: `ruby ./lib/crack.rb ./data/encrypted.txt ./data/cracked.txt <optional date>`

encrypted_filepath = ARGV[0]
encrypted_file = File.open(encrypted_filepath, "r")
encryption = encrypted_file.read.chomp

date = ARGV[2].nil? ? Enigma.new.todays_date : ARGV[2]
crack_hash = Enigma.new.crack(encryption, date)

cracked_filepath = ARGV[1]
cracked_file = File.open(cracked_filepath, "w")
cracked_file.write(crack_hash[:decryption])
cracked_file.close

puts "Created '#{cracked_filepath}' with the cracked key #{crack_hash[:key]} and date #{crack_hash[:date]}"

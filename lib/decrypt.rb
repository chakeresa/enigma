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

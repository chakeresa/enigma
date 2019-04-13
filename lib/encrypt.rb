require './lib/enigma'

# Use the CLI like this: `ruby ./lib/encrypt.rb ./data/message.txt ./data/encrypted.txt`

message_filepath = ARGV[0]
message_file = File.open(message_filepath, "r")
message = message_file.read

encrypt_hash = Enigma.new.encrypt(message)

encrypted_filepath = ARGV[1]
encrypted_file = File.open(encrypted_filepath, "w")
encrypted_file.write(encrypt_hash[:encryption])
encrypted_file.close

puts "Created '#{encrypted_filepath}' with the key #{encrypt_hash[:key]} and date #{encrypt_hash[:date]}"

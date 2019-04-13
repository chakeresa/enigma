# Cracking Interface
# Additionally, create a Runner file called crack.rb that takes three command line arguments. The first is an existing file that contains an encrypted message. The second is a file where your program should write the cracked message. The third is the date to be used for cracking. In addition to writing the cracked message to the file, your program should output to the screen the file it wrote to, the key used for cracking, and the date used for cracking:
#
# $ ruby ./lib/encrypt.rb message.txt encrypted.txt
# Created 'encrypted.txt' with the key 82648 and date 240818
# $ ruby ./lib/crack.rb encrypted.txt cracked.txt 240818
# Created 'cracked.txt' with the cracked key 82648 and date 240818

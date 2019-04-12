class Shifter
  CHARACTER_SET = ("a".."z").to_a << " "

  def self.shifted_set(shift)
    CHARACTER_SET.rotate(shift)
  end

  def self.shift_letter(letter, shift)
    letter.downcase!
    letter_position = CHARACTER_SET.find_index(letter)
    letter_position.nil? ? letter : shifted_set(shift)[letter_position]
  end
end

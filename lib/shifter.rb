class Shifter
  attr_reader :character_set

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def shifted_set(shift)
    @character_set.rotate(shift)
  end

  def shift_letter(letter, shift)
    letter.downcase!
    letter_position = @character_set.find_index(letter)
    letter_position.nil? ? letter : shifted_set(shift)[letter_position]
  end
end

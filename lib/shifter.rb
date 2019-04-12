class Shifter
  attr_reader :character_set

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def shifted_set(shift)
    @character_set.rotate(shift)
  end
end

class Shifter
  attr_reader :character_set

  def initialize
    @character_set = ("a".."z").to_a << " "
  end
end

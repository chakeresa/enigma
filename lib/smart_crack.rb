class SmartCrack
  attr_reader :ciphertext, :date, :end_of_msg, :shift_count

  def initialize(ciphertext, date, end_of_msg = " end")
    @ciphertext = ciphertext
    @date = date
    @end_of_msg = end_of_msg.downcase
    @shift_count = ShiftGenerator::SHIFT_COUNT
  end

  def last_four_chars
    date_shift_ary = DateShiftGenerator.new(@date).neg_shift_array
    date_shifted_msg = Enigma.new.translate(@ciphertext, date_shift_ary)
    date_shifted_msg[(-1 * @shift_count)..-1]
  end

  def abcd_index_of_last_four_chars
    msg_length = @ciphertext.length
    (0..(@shift_count - 1)).to_a.rotate(msg_length % @shift_count)
  end

  def min_possible_shifts
    min_poss_shifts = []
    last_four_chars.chars.each.with_index do |char, char_index|
      shift = find_single_shift(char, char_index)
      min_poss_shifts[abcd_index_of_last_four_chars[char_index]] = shift
    end
    min_poss_shifts
  end

  def find_single_shift(char, char_index)
    shift_guess = 0
    letter_wanted = @end_of_msg[char_index]
    while Shifter.shift_letter(char, -1 * shift_guess) != letter_wanted
      shift_guess += 1
    end
    shift_guess
  end

  def smart_crack
    # TO DO: break up with helper methods galore
    all_possible_shifts = min_possible_shifts.map do |possible_shift|
      all_shifts = [possible_shift]
      while all_shifts.last + 27 < 100
        all_shifts << all_shifts.last + 27
      end
      all_shifts.map {|shift| (shift + 1000).to_s[-2..-1]}
    end.rotate! #TO DO: check if working right with different length msg

    all_possible_shifts = filter_all_possible_shifts_fw(all_possible_shifts)
    key_shifts = filter_all_possible_shifts_bw(all_possible_shifts)

    key = ""
    key_shifts.flatten.each.with_index do |shift, index|
      index == 0 ? key << shift : key << shift.chars.last
    end

    Enigma.new.decrypt(@ciphertext, key, @date)
  end

  def valid_next_shift?(possible_next_shift, first_shift_ary)
    first_shift_ary.any? do |first_shift_elem|
      first_shift_elem.chars.last == possible_next_shift.chars.first
    end
  end

  def valid_prev_shift?(possible_prev_shift, next_shift_ary)
    next_shift_ary.any? do |next_shift_elem|
      next_shift_elem.chars.first == possible_prev_shift.chars.last
    end
  end

  def filtered_shift_ary_fw(first_shift_ary, next_shift_ary)
    next_shift_ary.find_all do |possible_next_shift|
      valid_next_shift?(possible_next_shift, first_shift_ary)
    end
  end

  def filtered_shift_ary_bw(prev_shift_ary, next_shift_ary)
    prev_shift_ary.find_all do |possible_prev_shift|
      valid_prev_shift?(possible_prev_shift, next_shift_ary)
    end
  end

  def filter_all_possible_shifts_fw(all_possible_shifts)
    for i in 0..(all_possible_shifts.length - 2) do
      opt_ary_prev = all_possible_shifts[i]
      opt_ary_next = all_possible_shifts[i+1]
      all_possible_shifts[i+1] = filtered_shift_ary_fw(opt_ary_prev, opt_ary_next)
    end
    all_possible_shifts
  end

  def filter_all_possible_shifts_bw(all_possible_shifts)
    for i in 0..(all_possible_shifts.length - 2) do
      prev_index = all_possible_shifts.length - 2 - i
      opt_ary_prev = all_possible_shifts[prev_index]
      opt_ary_next = all_possible_shifts[prev_index+1]
      all_possible_shifts[prev_index] = filtered_shift_ary_bw(opt_ary_prev, opt_ary_next)
    end
    all_possible_shifts
  end
end

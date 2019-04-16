module SmartCrack
    def smart_crack(ciphertext, date = todays_date)
      end_of_msg = " end"
      msg_length = ciphertext.length
      shift_count = ShiftGenerator::SHIFT_COUNT
      last_four_char_shift_indices = (0..(shift_count - 1)).to_a.rotate(msg_length % shift_count)
      date_shift_ary = DateShiftGenerator.new(date).neg_shift_array
      date_shifted_msg = translate(ciphertext, date_shift_ary)
      last_four_chars = date_shifted_msg[(-1 * shift_count)..-1]
      min_possible_shifts = []
      last_four_chars.chars.each.with_index do |char, char_index|
        shift_guess = 0
        while Shifter.shift_letter(char, -1 * shift_guess) != end_of_msg[char_index]
          shift_guess += 1
        end
        min_possible_shifts[char_index] = shift_guess
      end

      all_possible_shifts = min_possible_shifts.map do |possible_shift|
        all_shifts = [possible_shift]
        while all_shifts.last + 27 < 100
          all_shifts << all_shifts.last + 27
        end
        all_shifts.map {|shift| (shift + 1000).to_s[-2..-1]}
      end.rotate! # check if working right with different length msg

      # all_possible_shifts = filter_all_possible_shifts_fw(all_possible_shifts)
      #
      # require "pry"; binding.pry

      # refactor all below

      filtered_options = []
      all_possible_shifts.each_cons(2) do |opt_ary_1, opt_ary_2|
        last_digits_1 = opt_ary_1.map do |possible_shift_1|
          possible_shift_1.chars.last
        end
        first_digits_2 = opt_ary_2.map do |possible_shift_2|
          possible_shift_2.chars.first
        end
        overlap = last_digits_1 & first_digits_2
        filtered_options << overlap
      end

      key_shifts = []
      key_shifts[1] = all_possible_shifts[1].find_all do |shift1|
        filtered_options[0].include?(shift1.chars.first) && filtered_options[1].include?(shift1.chars.last)
      end
      key_shifts[2] = all_possible_shifts[2].find_all do |shift2|
        shift2.chars.first == key_shifts[1][0].chars.last && filtered_options[1].include?(shift2.chars.first) && filtered_options[2].include?(shift2.chars.last)
      end
      key_shifts[3] = all_possible_shifts[3].find_all do |shift3|
        shift3.chars.first == key_shifts[2][0].chars.last && filtered_options[2].include?(shift3.chars.first)
      end
      key_shifts[0] = all_possible_shifts[0].find_all do |shift0|
        shift0.chars.last == key_shifts[1][0].chars.first && filtered_options[0].include?(shift0.chars.last)
      end

      key = ""
      key_shifts.flatten.each.with_index do |shift, index|
        if index == 0
          key << shift
        else
          key << shift.chars.last
        end
      end
      decrypt(ciphertext, key, date)
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

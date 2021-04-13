class Interface

  def show_rules()
  end

  def show_board(spaces, p1, p2)
    ranks = ("1".."8").to_a.reverse
    board_display = "    (a)(b)(c)(d)(e)(f)(g)(h)\n"
    board_display += "                            \n"

    j = 8
    8.times do |i|
      j -= 1
      board_display += "(#{ranks[i]}) "
      spaces.keys.each do |file|
        space = spaces[file][j]
        unless space == ' '
          board_display += "[#{space.icon}]"
        else
          board_display += "[#{space}]"
        end
      end
      board_display += "\n"
    end
    puts board_display
  end
  # columns (files) are lettered
  # rows (ranks) are numbered

  def ask_for_file()
    puts "\nEnter a letter for the file."
  end

  def ask_for_rank()
    puts "\nEnter a number for the rank."
  end

  def show_piece_select()
    puts "\nSelect a piece to move."
  end

  def show_destination_select()
    puts "\nSelect a destination."
  end

  def show_invalid_destination()
  end

  def show_invalid_input()
    puts "\nInvalid input."
  end

  def show_invalid_selection(coordinates)
    x = coordinates[0]
    y = coordinates[1]
    puts "[#{x},#{y}] does not contain one of your pieces."
  end

  def show_invalid_move()
  end

end

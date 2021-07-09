class Interface

  def show_rules()
  end

  def show_players(p1, p2)
    puts "\n#{p1.name}: #{p1.color}"
    puts "#{p2.name}: #{p2.color}"
  end

  def show_board(spaces)
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
    cancel_command = "                    y) cancel\n"
    board_display = board_display + "\n" + cancel_command
    puts board_display
  end
  # columns (files) are lettered
  # rows (ranks) are numbered

  def ask_for_file(type)
    puts "\nEnter a letter for the file. (#{type})"
  end

  def ask_for_rank(type)
    puts "\nEnter a number for the rank. (#{type})"
  end

  def show_piece_select()
    puts "Select a piece to move."
  end

  def show_destination_select()
    puts "\nSelect a destination."
  end

  def show_canceled_move_input()
    puts "\nInput canceled. Select a new piece to move."
  end

  def show_invalid_destination()
    puts 'Cannot move to that space.'
  end

  def show_invalid_input()
    puts "\nInvalid input."
  end

  def show_king_check()
    puts "\nKing is in check."
  end

  def show_move_into_check()
    puts 'Invalid move. Cannot put own king in check.'
  end

  def show_escape_check()
    puts 'Invalid move. King Still in check.'
  end

  def show_pawn_promotion()
    puts 'Pawn has reached final rank. Pawn may be promoted. Select a piece.'
    puts '1) Queen  2) Bishop'
    puts '3) Knight 4) Rook'
  end

  def show_invalid_selection(coordinates)
    x = ('a'..'h').to_a[coordinates[0]].upcase
    y = coordinates[1] + 1
    puts "#{x}#{y} does not contain one of your pieces."
  end

end

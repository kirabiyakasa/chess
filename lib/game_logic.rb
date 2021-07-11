require 'yaml'

class GameLogic

  def initialize(interface, board)
    @interface = interface
    @board = board
    @current_turn = nil
  end

  def play_game()
    @current_turn = 'white'
    move_white()
  end

  def resume_game()
    if @current_turn == 'white'
      move_white()
    else
      move_black()
    end
  end

  private

  def move_white()
    white_king = @board.white_king
    @board.p1.color == 'white' ? player = @board.p1 : player = @board.p2
    @interface.show_players(@board.p1, @board.p2)
    @interface.show_board(@board.spaces)
    move_resolved = false

    puts "\n#{player.name}'s Turn."
    unless end_game?(white_king)
      until move_resolved == true || move_resolved == 'save'
        move_resolved = @board.move_piece(@interface, player, white_king)
      end
      save_game(self) if move_resolved == 'save'
    end
    @current_turn = 'black'
    move_black()
  end

  def move_black()
    black_king = @board.black_king
    @board.p1.color == 'black' ? player = @board.p1 : player = @board.p2
    @interface.show_players(@board.p1, @board.p2)
    @interface.show_board(@board.spaces)
    move_resolved = false

    puts "\n#{player.name}'s Turn."
    unless end_game?(black_king)
      until move_resolved == true || move_resolved == 'save'
        move_resolved = @board.move_piece(@interface, player, black_king)
      end
      save_game(self) if move_resolved == 'save'
    end
    @current_turn = 'white'
    move_white()
  end

  def end_game?(king)
    black_king = @board.black_king
    king_coords = @board.get_piece_coords(king)
    check = king.checked?(king_coords, @board.spaces)

    case check
    when true
      if king.checkmate?(king_coords, @board.spaces, @board)
        game_over('checkmate')
      end
      @interface.show_king_check
    when false
      if king.stalemate?(king_coords, @board)
        game_over('stalemate')
      end
    end
    return false 
  end

  def game_over(condition)
    if condition == 'checkmate'
      if @board.p1.color == king.color
        show_checkmate(@board.p2, @board.p1)
      else
        show_checkmate(@board.p1, @board.p2)
      end
      @interface.show_play_again
      play_again?()
    elsif condition == 'stalemate'
      if @board.p1.color == king.color
        show_stalemate(@board.p2)
      else
        show_stalemate(@board.p1)
      end
      play_again?()
    end
  end

  def play_again?()
    input = gets.chomp
    until input == '1' || input == '2'
      puts 'Invalid input.'
      input = gets.chomp
    end
    if input == '1'
      new_game(@interface)
    elsif input '2'
      start_game(@interface)
    end
  end

end

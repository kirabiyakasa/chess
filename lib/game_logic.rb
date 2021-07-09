require 'pry'

class GameLogic

  def initialize(interface, board)
    @interface = interface
    @board = board
  end

  def play_game()
    move_white()
  end

  private

  def move_white()
    white_king = @board.white_king
    @board.p1.color == 'white' ? player = @board.p1 : player = @board.p2
    @interface.show_board(@board.spaces, @board.p1, @board.p2)
    move_resolved = false

    unless end_game?(white_king)
      until move_resolved == true
        move_resolved = @board.move_piece(@interface, player, white_king)
      end
    end
    move_black()
  end

  def move_black()
    black_king = @board.black_king
    @board.p1.color == 'black' ? player = @board.p1 : player = @board.p2
    @interface.show_board(@board.spaces, @board.p1, @board.p2)
    move_resolved = false

    unless end_game?(black_king)
      until move_resolved == true
        move_resolved = @board.move_piece(@interface, player, black_king)
      end
    end
    move_white()
  end

  def end_game?(king)
    black_king = @board.black_king
    king_coords = @board.get_piece_coords(king)
    check = king.checked?(king_coords, @board.spaces)

    case check
    when true
      if king.checkmate?(king_coords, @board.spaces, @board)
        # show lost game
      end
    when false
      if king.stalemate?(king_coords, @board)
        # show stalemate
      end
    end
    return false 
  end

end

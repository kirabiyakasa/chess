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

    king_coords = @board.get_piece_coords(white_king)
    check = white_king.checked?(king_coords, @board.spaces)
    stalemate = white_king.stalemate?
    unless check #|| stalemate
      until move_resolved == true
        move_resolved = @board.move_piece(@interface, player)
      end
    else
      if checkmate?(king_coords, @board.spaces, @board)
        # black wins
      #elsif stalemate?()
      end
    end
    move_black()
  end

  def move_black()
    @board.p1.color == 'black' ? player = @board.p1 : player = @board.p2
    @interface.show_board(@board.spaces, @board.p1, @board.p2)
    move_resolved = false
    until move_resolved == true
      move_resolved = @board.move_piece(@interface, player)
    end
    move_white()
  end

end

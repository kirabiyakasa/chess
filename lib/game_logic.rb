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
    @board.p1.color == 'white' ? player = @board.p1 : player = @board.p2
    @interface.show_board(@board.spaces, @board.p1, @board.p2)
    move_resolved = false
    until move_resolved == true
      move_resolved = @board.move_piece(@interface, player)
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

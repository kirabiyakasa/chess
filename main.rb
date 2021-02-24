require './lib/interface.rb'
require './lib/board.rb'
require './lib/player.rb'
require './lib/game_logic.rb'


def start_game()
  interface = Interface.new
  interface.show_rules
  colors = ['white', 'black']
  player1 = Player.new(colors, 'player 1')
  player2 = Player.new(colors, 'player 2')
  board = Board.new(player1, player2)
  game = GameLogic.new(interface, board)
  game.play_game
end
start_game()

# check if move is valid
# check if king is in check and disallow all other moves
# remove piece if captured
# resolve move
# switch to black, and do the same
# alternate black and white

# allow for castling
# allow for piece recovery if pawn reaches other side of the board

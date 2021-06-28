require './lib/interface.rb'
require './lib/board.rb'
require './lib/player.rb'
require './lib/game_logic.rb'

def get_name(player_num)
  puts "\nEnter a name for #{player_num}."
  name = gets.chomp
  return name
end

def choose_color(colors, name)
  if colors.length == 2
    puts "\nSelect a Color for #{name}."
    puts "\n1) Black    2) White"
    answer = gets.chomp
    until answer == '1' || answer == '2'
      puts 'Please Enter a valid input.'
      answer = gets.chomp
    end
    answer == '1' ? color = colors.shift : color = colors.pop
  else
    color = colors.pop
  end
  return color
end

def setup_players(colors)
  p1_name = get_name('player 1')
  p1_color = choose_color(colors, p1_name)

  p2_name = get_name('player 2')
  p2_color = colors[0]

  player1 = Player.new(p1_color, p1_name)
  player2 = Player.new(p2_color, p2_name)

  return [player1, player2]
end

def start_game()
  interface = Interface.new
  interface.show_rules
  colors = ['white', 'black']
  players = setup_players(colors)
  board = Board.new(players[0], players[1])
  game = GameLogic.new(interface, board)
  game.play_game
end
start_game()

# check if king is in check and disallow all other moves

# allow for castling
# allow for piece recovery if pawn reaches other side of the board

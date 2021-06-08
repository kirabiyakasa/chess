
require 'pry'

require './board_builder'
require './board'
require './player'

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#checkmate?' do
      
      context 'When checked but not in checkmate.' do
        context 'When forced to move the king.' do
          it 'Returns 2 valid moves when checked by a rook and bishop.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            black_rook = spaces[0][7]
            spaces[0][5] = black_rook
            spaces[0][7] = ' '

            black_bishop = spaces[5][7]
            spaces[1][3] = black_bishop
            spaces[5][7] = ' '

            white_king = spaces[4][0]
            spaces[0][4] = white_king
            spaces[4][0] = ' '

            subject.checked?([0, 4], spaces)
            expect(subject.checkmate?([0, 4], spaces, board).count).to eql(2)
          end

          it 'Returns 5 valid moves when checked by a queen and knight.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            black_queen = spaces[3][7]
            spaces[3][5] = black_queen
            spaces[3][7] = ' '

            black_knight = spaces[6][7]
            spaces[6][5] = black_knight
            spaces[6][7] = ' '

            black_pawn = spaces[0][6]
            spaces[4][3] = black_pawn
            spaces[0][6] = ' '

            white_king = spaces[4][0]
            spaces[5][3] = white_king
            spaces[4][0] = ' '

            subject.checked?([5, 3], spaces)
            expect(subject.checkmate?([5, 3], spaces, board).count).to eql(5)
          end
        end

        context 'When forced to block the enemy piece.' do
          it 'Returns 5 valid moves when checked by a bishop.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            black_bishop = spaces[5][7]
            spaces[2][2] = black_bishop
            spaces[5][7] = ' '

            spaces[3][1] = ' '

            subject.checked?([4, 0], spaces)
            expect(subject.checkmate?([4, 0], spaces, board).count).to eql(5)
          end
        end

      end
    end

  end
end

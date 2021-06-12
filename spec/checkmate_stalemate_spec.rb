
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
          xit 'Returns 2 valid moves when checked by a rook and bishop.' do
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

          xit 'Returns 5 valid moves when checked by a queen and knight.' do
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
          xit 'Returns 5 valid moves when checked by a bishop.' do
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

          xit 'Returns 1 valid move when checked by a rook.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            black_rook = spaces[0][7]
            spaces[4][3] = black_rook
            spaces[0][7] = ' '

            black_rook2 = spaces[7][7]
            spaces[3][3] = black_rook2
            spaces[7][7] = ' '

            black_queen = spaces[3][7]
            spaces[5][3] = black_queen
            spaces[5][7] = ' '

            white_rook = spaces[0][0]
            spaces[4][5] = white_rook
            spaces[0][0] = ' '

            white_king = spaces[4][0]
            spaces[4][1] = white_king
            spaces[4][0] = ' '

            subject.checked?([4, 1], spaces)
            expect(subject.checkmate?([4, 1], spaces, board).count).to eql(1)
          end
        end

        context 'When able to move king or block' do
          xit 'Returns 7 valid moves when checked by a pawn.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            black_pawn = spaces[3][6]
            spaces[3][5] = black_pawn
            spaces[3][6] = ' '

            white_rook = spaces[0][0]
            spaces[3][2] = white_rook
            spaces[0][0] = ' '

            white_knight = spaces[6][0]
            spaces[5][4] = white_knight
            spaces[6][0] = ' '

            white_king = spaces[4][0]
            spaces[2][4] = white_king
            spaces[4][0] = ' '

            subject.checked?([2, 4], spaces)
            expect(subject.checkmate?([2, 4], spaces, board).count).to eql(7)
          end
        end
      end

    end

  end

  context 'Color is black' do
    subject { King.new('black') }

    describe '#checkmate?' do

      context 'When checked but not in checkmate.' do
        context 'When forced to move the king' do
          it 'Returns 4 valid moves when checked by two rooks.' do
            p1 = Player.new('white', 'p1')
            p2 = Player.new('black', 'p2')

            board = Board.new(p1, p2)
            spaces = board.spaces

            white_rook1 = spaces[0][0]
            spaces[0][4] = white_rook1
            spaces[0][0] = ' '

            white_rook2 = spaces[7][0]
            spaces[4][2] = white_rook2
            spaces[7][0] = ' '

            black_king = spaces[4][7]
            spaces[4][4] = black_king
            spaces[4][7] = ' '

            subject.checked?([4, 4], spaces)
            expect(subject.checkmate?([4, 4], spaces, board).count).to eql(4)
          end
        end
      end

    end

  end

end

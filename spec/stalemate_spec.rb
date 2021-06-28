
require 'pry'

require './lib/board_builder'
require './lib/board'
require './lib/player'

p1 = Player.new('white', 'p1')
p2 = Player.new('black', 'p2')

def delete_white_rows(spaces)
  spaces.keys.each do |column|
    2.times do |i|
      spaces[column][i] = ' '
    end
  end
end

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#stalemate?' do

      context 'When in stalemate.' do
        context 'When only the king is left.' do
          it 'Returns true when put in stalemate by rook and queen.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]

            delete_white_rows(spaces)

            spaces[7][0] = white_king

            black_rook = spaces[0][7]
            spaces[0][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(true)
          end

        end

        context 'When pieces in addition to the king remain.' do
          it 'Returns false when able to move rook.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_rook = spaces[0][0]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[0][0] = white_rook

            black_rook = spaces[0][7]
            spaces[0][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(false)
          end

          it 'Returns false when able to move a bishop.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_bishop = spaces[2][0]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[0][0] = white_bishop

            black_rook = spaces[0][7]
            spaces[0][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(false)
          end

          it 'Returns false when able to move a knight.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_knight = spaces[1][0]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[0][0] = white_knight

            black_rook = spaces[0][7]
            spaces[0][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(false)
          end

          it 'Returns false when able to move a pawn.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_pawn = spaces[0][1]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[0][1] = white_pawn

            black_rook = spaces[0][7]
            spaces[1][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(false)
          end

          it 'Returns true when unable to move a pawn.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_pawn = spaces[0][1]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[1][0] = white_pawn

            black_rook = spaces[0][7]
            spaces[1][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(white_king.stalemate?([7, 0], board)).to eql(true)
          end

          it 'Returns false when only able to move a pawn via en passant.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_pawn = spaces[0][1]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[0][4] = white_pawn

            black_pawn1 = spaces[0][6]
            spaces[0][5] = black_pawn1
            spaces[0][6] = ' '

            black_rook = spaces[0][7]
            spaces[1][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            black_pawn2 = spaces[1][6]
            black_pawn2.check_legal_move([1, 6], [1, 4], spaces)
            spaces[1][4] = black_pawn2

            expect(white_king.stalemate?([7, 0], board)).to eql(false)
          end
        end

      end

    end

  end
end

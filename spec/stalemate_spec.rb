
require 'pry'

require './lib/board_builder'
require './lib/board'
require './lib/player'

p1 = Player.new('white', 'p1')
p2 = Player.new('black', 'p2')

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#stalemate?' do

      context 'When in stalemate.' do
        context 'When only the king is left.' do
          it 'Returns true when put into stalemate by rook and queen.' do
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

            expect(subject.stalemate?([7, 0], board)).to eql(true)
          end

          it 'Returns true when put into stalemate by pawns' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]

            delete_white_rows(spaces)

            spaces[3][0] = white_king

            black_pawn1 = spaces[1][6]
            spaces[1][2] = black_pawn1
            spaces[1][6] = ' '

            black_pawn2 = spaces[2][6]
            spaces[2][2] = black_pawn2
            spaces[2][6] = ' '

            black_pawn3 = spaces[3][6]
            spaces[3][1] = black_pawn3
            spaces[3][6] = ' '

            black_pawn4 = spaces[4][6]
            spaces[4][2] = black_pawn4
            spaces[4][6] = ' '

            black_pawn5 = spaces[5][6]
            spaces[5][2] = black_pawn5
            spaces[5][6] = ' '

            expect(subject.stalemate?([3, 0], board)).to eql(true)
          end

          it 'Returns false when able to move king.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]

            delete_white_rows(spaces)

            spaces[4][0] = white_king

            expect(subject.stalemate?([4, 0], board)).to eql(false)
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

            expect(subject.stalemate?([7, 0], board)).to eql(false)
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

            expect(subject.stalemate?([7, 0], board)).to eql(false)
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

            expect(subject.stalemate?([7, 0], board)).to eql(false)
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

            expect(subject.stalemate?([7, 0], board)).to eql(false)
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

            expect(subject.stalemate?([7, 0], board)).to eql(true)
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
            spaces[1][6] = ' '

            expect(subject.stalemate?([7, 0], board)).to eql(false)
          end

          it 'Returns true when unable to move a pawn' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            white_king = spaces[4][0]
            white_pawn = spaces[0][1]

            delete_white_rows(spaces)

            spaces[7][0] = white_king
            spaces[2][3] = white_pawn

            black_pawn1 = spaces[2][6]
            spaces[2][4] = black_pawn1
            black_pawn1.check_legal_move([2, 6], [2, 4], spaces)
            spaces[2][6] = ' '

            black_pawn2 = spaces[1][6]
            spaces[1][3] = black_pawn2
            spaces[1][6] = ' '

            black_rook = spaces[0][7]
            spaces[1][1] = black_rook
            spaces[0][7] = ' '

            black_queen = spaces[3][7]
            spaces[6][5] = black_queen
            spaces[3][7] = ' '

            expect(subject.stalemate?([7, 0], board)).to eql(true)
          end
        end

      end

    end

  end

  context 'color is black' do
    subject { King.new('black') }

    describe '#stalemate?' do

      context 'When in stalemate.' do
        context 'When only the king is left.' do
          it 'Returns true when put into stalemate by a knight and rook.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_king = spaces[4][7]

            delete_black_rows(spaces)

            spaces[0][7] = black_king

            white_knight = spaces[1][0]
            spaces[2][5] = white_knight
            spaces[1][0] = ' '

            white_bishop = spaces[2][0]
            spaces[0][5] = white_bishop
            spaces[2][0] = ' '

            expect(subject.stalemate?([0, 7], board)).to eql(true)
          end

          it 'Returns false when able to move a bishop' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_king = spaces[4][7]
            black_bishop = spaces[2][7]

            delete_black_rows(spaces)

            spaces[0][7] = black_king
            spaces[1][7] = black_bishop

            white_knight = spaces[1][0]
            spaces[2][5] = white_knight
            spaces[1][0] = ' '

            white_bishop = spaces[2][0]
            spaces[0][5] = white_bishop
            spaces[2][0] = ' '

            expect(subject.stalemate?([0, 7], board)).to eql(false)
          end

          it 'Returns false when able to move a queen' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_king = spaces[4][7]
            black_queen = spaces[3][7]

            delete_black_rows(spaces)

            spaces[0][7] = black_king
            spaces[1][7] = black_queen

            white_knight = spaces[1][0]
            spaces[2][5] = white_knight
            spaces[1][0] = ' '

            white_bishop = spaces[2][0]
            spaces[0][5] = white_bishop
            spaces[2][0] = ' '

            expect(subject.stalemate?([0, 7], board)).to eql(false)
          end

          it 'Returns true when put into stalemate by pawns' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_king = spaces[4][7]

            delete_black_rows(spaces)

            spaces[0][7] = black_king

            white_pawn1 = spaces[0][1]
            spaces[0][5] = white_pawn1
            spaces[0][1] = ' '

            white_pawn2 = spaces[1][1]
            spaces[1][5] = white_pawn2
            spaces[1][1] = ' '

            white_pawn3 = spaces[2][1]
            spaces[2][6] = white_pawn3
            spaces[2][1] = ' '

            expect(subject.stalemate?([0, 7], board)).to eql(true)
          end
        end
      end

    end

  end
end

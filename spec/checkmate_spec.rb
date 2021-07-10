require './lib/board_builder'
require './lib/board'
require './lib/player'

p1 = Player.new('white', 'p1')
p2 = Player.new('black', 'p2')

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#checkmate?' do
      
      context 'When checked but not in checkmate.' do
        context 'When forced to move the king.' do
          it 'Returns 2 valid moves when checked by a rook and bishop.' do
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
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_queen = spaces[3][7]
            spaces[3][5] = black_queen
            spaces[3][7] = ' '

            black_knight = spaces[6][7]
            spaces[6][5] = black_knight
            spaces[6][7] = ' '

            black_pawn = spaces[6][6]
            spaces[4][3] = black_pawn
            spaces[1][6] = ' '

            white_king = spaces[4][0]
            spaces[5][3] = white_king
            spaces[4][0] = ' '

            subject.checked?([5, 3], spaces)
            expect(subject.checkmate?([5, 3], spaces, board).count).to eql(5)
          end
        end

        context 'When forced to block the enemy piece.' do
          it 'Returns 5 valid moves when checked by a bishop.' do
            board = Board.new(p1, p2)
            spaces = board.spaces

            black_bishop = spaces[5][7]
            spaces[2][2] = black_bishop
            spaces[5][7] = ' '

            spaces[3][1] = ' '

            subject.checked?([4, 0], spaces)
            expect(subject.checkmate?([4, 0], spaces, board).count).to eql(5)
          end

          it 'Returns 1 valid move when checked by a rook.' do
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
          it 'Returns 7 valid moves when checked by a pawn.' do
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

      context 'When in checkmate.' do
        it 'Returns 0 when put into checkmate by queen and bishop.' do
          board = Board.new(p1, p2)
          spaces = board.spaces
  
          black_queen = spaces[3][7]
          spaces[5][1] = black_queen
          spaces[3][7] = ' '
  
          black_bishop = spaces[5][7]
          spaces[6][2] = black_bishop
          spaces[5][7] = ' '
  
          expect(subject.checkmate?([4, 0], spaces, board).count).to eql(0)
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

      context 'When in checkmate.' do
        it 'Returns 0 when put into checkmate by bishop and pawns.' do
          board = Board.new(p1, p2)
          spaces = board.spaces

          black_king = spaces[4][7]

          delete_black_rows(spaces)

          spaces[7][7] = black_king

          white_pawn1 = spaces[7][1]
          spaces[7][6] = white_pawn1
          spaces[7][1] = ' '

          white_pawn2 = spaces[6][1]
          spaces[6][5] = white_pawn2
          spaces[6][1] = ' '

          bishop = spaces[2][0]
          spaces[2][2] = bishop
          spaces[2][0] = ' '

          expect(subject.checkmate?([7, 7], spaces, board).count).to eql(0)
        end

        it 'Return 0 when put into checkmate by knights, rooks, and queen.' do
          board = Board.new(p1, p2)
          spaces = board.spaces

          black_king = spaces[4][7]

          delete_black_rows(spaces)

          spaces[3][4] = black_king

          white_rook1 = spaces[0][0]
          spaces[0][5] = white_rook1
          spaces[0][0] = ' '

          white_knight1 = spaces[1][0]
          spaces[2][6] = white_knight1
          spaces[1][0] = ' '

          white_queen = spaces[3][0]
          spaces[2][2] = white_queen
          spaces[3][0] = ' '

          white_knight2 = spaces[6][0]
          spaces[5][2] = white_knight2
          spaces[6][0] = ' '

          white_rook2 = spaces[7][0]
          spaces[7][3] = white_rook2
          spaces[7][0] = ' '

          expect(subject.checkmate?([3, 4], spaces, board).count).to eql(0)
        end
      end

    end

  end

end

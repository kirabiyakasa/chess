
require 'pry'

require './lib/board_builder'
require './lib/board'
require './lib/player'

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#check_legal_move' do
      context 'When performing basic moves.' do
        it 'Returns true when moving king diagonally one space.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board
  
          spaces[5][1] = ' '
          
          expect(subject.check_legal_move([4, 0], [5, 1], spaces)).to eql(true)
        end
  
        it 'Returns false when moving king onto one\'s own pawn' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board
          
          expect(subject.check_legal_move([4, 0], [5, 1], spaces)).to eql(false)
        end
      end

      context 'When attempting to castle left.' do
        it 'Returns true when castling to the left.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(true)
        end

        it 'Returns false when castling left, but rook has already moved.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          rook = spaces[0][0]
          rook.check_legal_move([0, 0], [1, 0], spaces)
          
          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false when castling left, but king has already moved.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          subject.check_legal_move([4, 0], [3, 0], spaces)

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false when castling left, but ally piece is blocking.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[2][0] = ' '
          spaces[1][0] = ' '

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false when trying to castle left through check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '
          spaces[3][1] = ' '
          black_rook = spaces[0][7]
          spaces[3][2] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false when trying to castle left out of check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '
          spaces[4][1] = ' '

          black_rook = spaces[0][7]
          spaces[4][2] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns true when trying to castle left, and rook passes through
            space targeted by enemy piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          black_rook = spaces[0][7]
          spaces[1][1] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(true)
        end

        it 'Returns true when castling left and rook is targeted by enemy' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          black_rook = spaces[0][7]
          spaces[0][1] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(true)
        end

        it 'Returns false when castling left, but enemy piece is blocking' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          black_rook = spaces[0][7]
          spaces[1][0] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false when trying to castle into check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          black_rook = spaces[0][7]
          spaces[2][1] = black_rook

          expect(subject.check_legal_move([4, 0], [2, 0], spaces)).to eql(false)
        end

        it 'Returns false castling left, but moving too many spaces.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][0] = ' '
          spaces[2][0] = ' '
          spaces[1][0] = ' '

          expect(subject.check_legal_move([4, 0], [1, 0], spaces)).to eql(false)
        end
      end

      context 'When attempting to castle right.' do
        it 'Returns true when castling right.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[5][0] = ' '
          spaces[6][0] = ' '

          expect(subject.check_legal_move([4, 0], [6, 0], spaces)).to eql(true)
        end

        it 'Returns true when castling right and rook is targeted by enemy' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[5][0] = ' '
          spaces[6][0] = ' '
          spaces[6][1] = ' '

          black_bishop = spaces[2][7]
          spaces[5][2] = black_bishop

          expect(subject.check_legal_move([4, 0], [6, 0], spaces)).to eql(true)
        end

        it 'Returns false when trying to castle right through check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[5][0] = ' '
          spaces[6][0] = ' '

          black_knight = spaces[1][7]
          spaces[6][2] = black_knight

          expect(subject.check_legal_move([4, 0], [6, 0], spaces)).to eql(false)
        end
      end
    end

  end

  context 'color is black' do
    subject { King.new('black') }

    describe '#check_legal_move' do
      context 'When performing basic moves.' do
        it 'Returns true when moving king vertically one space.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[4][6] = ' '

          expect(subject.check_legal_move([4, 7], [4, 6], spaces)).to eql(true)
        end

        it 'Returns true when moving king horizontally one space.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][7] = ' '

          expect(subject.check_legal_move([4, 7], [3, 7], spaces)).to eql(true)
        end

        it 'Returns false when moving king diagonally more than once.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][6] = ' '

          expect(subject.check_legal_move([4, 7], [2, 5], spaces)).to eql(false)
        end

        it 'Returns false when moving king vertically more than once.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[4][6] = ' '

          expect(subject.check_legal_move([4, 7], [4, 5], spaces)).to eql(false)
        end

        it 'Returns false when trying to move to the space already occupied.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([4, 7], [4, 7], spaces)).to eql(false)
        end

        it 'Returns false when trying to move diagonally into check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[2][0]
          spaces[5][4] = white_bishop

          expect(subject.check_legal_move([4, 7], [3, 6], spaces)).to eql(false)
        end
      end

      context 'When attempting to castle right.' do
        it 'Returns true when castling right.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[5][7] = ' '
          spaces[6][7] = ' '

          expect(subject.check_legal_move([4, 7], [6, 7], spaces)).to eql(true)
        end

        it 'Returns false when trying to castle right, but checked by pawn.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[5][7] = ' '
          spaces[6][7] = ' '

          white_pawn = spaces[3][1]
          spaces[3][6] = white_pawn

          expect(subject.check_legal_move([4, 7], [6, 7], spaces)).to eql(false)
        end
      end
    end

  end
end

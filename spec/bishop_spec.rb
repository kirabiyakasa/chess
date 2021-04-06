require './board_builder'

require 'pry'

describe Bishop do
  context 'color is White' do
    subject { Bishop.new('white') }

    describe '#check_legal_move' do

      context 'When moving vertically or horizontally.' do
        it 'Returns false when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[1][2]
          spaces[3][2] = white_pawn
          spaces[1][2] = ' '

          expect(subject.check_legal_move([0, 2], [1, 2], spaces)).to eql(false)
        end

        it 'Returns false when moving horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[0][2]
          spaces[2][2] = white_bishop
          spaces[0][2] = ' '

          expect(subject.check_legal_move([2, 2], [2, 3], spaces)).to eql(false)
        end

        it 'Returns false when capturing vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[0][2]
          spaces[5][3] = white_bishop
          spaces[0][2] = ' '

          expect(subject.check_legal_move([5, 3], [6, 3], spaces)).to eql(false)
        end

        it 'Returns false when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_pawn = spaces[6][4]
          spaces[5][4] = black_pawn
          spaces[6][4] = ' '

          white_bishop = spaces[0][2]
          spaces[5][3] = white_bishop
          spaces[0][2] = ' '

          expect(subject.check_legal_move([5, 3], [5, 4], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns true when moving diagonally a single space.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[1][3]
          spaces[2][3] = white_pawn
          spaces[1][3] = ' '

          expect(subject.check_legal_move([0, 2], [1, 3], spaces)).to eql(true)
        end

        it 'Returns true when moving diagonally multiple spaces.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[1][3]
          spaces[2][3] = white_pawn
          spaces[1][3] = ' '

          expect(subject.check_legal_move([0, 2], [2, 4], spaces)).to eql(true)
        end

        it 'Returns false when moving diagonally through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 2], [2, 4], spaces)).to eql(true)
        end

        it 'Returns true when capturing an opponent\'s piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[0][2]
          spaces[5][3] = white_bishop
          spaces[0][2] = ' '

          expect(subject.check_legal_move([5, 3], [6, 4], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 2], [1, 3], spaces)).to eql(false)
        end
      end

    end
  end

  context 'color is black' do
    subject { Bishop.new('black') }

    describe '#check_legal_move' do

      context 'When moving vertically or horizontally' do
        it 'returns false when moving vertically multiple spaces.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_pawn = spaces[6][2]
          spaces[4][2] = black_pawn
          spaces[6][2] = ' '

          expect(subject.check_legal_move([7, 2], [5, 2], spaces)).to eql(false)
        end

        it 'returns false when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[1][2]
          spaces[5][3] = white_pawn
          spaces[1][2] = ' '

          black_bishop = spaces[7][2]
          spaces[5][2] = black_bishop
          spaces[7][2] = ' '

          expect(subject.check_legal_move([5, 2], [5, 3], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns true when capturing diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_bishop = spaces[7][2]
          spaces[5][2] = black_bishop
          spaces[5][2] = ' '

          white_rook = spaces[0][0]
          spaces[4][3] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([5, 2], [4, 3], spaces)).to eql(true)
        end
      end

    end

  end
end

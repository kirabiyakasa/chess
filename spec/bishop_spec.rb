require './board_builder'

describe Bishop do
  context 'color is White' do
    subject { Bishop.new('white') }

    describe '#check_legal_move' do

      context 'When moving vertically or horizontally.' do
        it 'Returns false when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[2][1]
          spaces[2][3] = white_pawn
          spaces[2][1] = ' '

          expect(subject.check_legal_move([2, 0], [2, 1], spaces)).to eql(false)
        end

        it 'Returns false when moving horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[2][0]
          spaces[2][2] = white_bishop
          spaces[2][0] = ' '

          expect(subject.check_legal_move([2, 2], [3, 2], spaces)).to eql(false)
        end

        it 'Returns false when capturing vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[2][0]
          spaces[3][5] = white_bishop
          spaces[2][0] = ' '

          expect(subject.check_legal_move([3, 5], [3, 6], spaces)).to eql(false)
        end

        it 'Returns false when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_pawn = spaces[4][6]
          spaces[4][5] = black_pawn
          spaces[4][6] = ' '

          white_bishop = spaces[2][0]
          spaces[3][5] = white_bishop
          spaces[2][0] = ' '

          expect(subject.check_legal_move([3, 5], [4, 5], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns true when moving diagonally a single space.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[3][1]
          spaces[3][2] = white_pawn
          spaces[3][1] = ' '

          expect(subject.check_legal_move([2, 0], [3, 1], spaces)).to eql(true)
        end

        it 'Returns true when moving diagonally multiple spaces.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[3][1]
          spaces[3][2] = white_pawn
          spaces[3][1] = ' '

          expect(subject.check_legal_move([2, 0], [4, 2], spaces)).to eql(true)
        end

        it 'Returns false when moving diagonally through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([2, 0], [4, 2], spaces)).to eql(false)
        end

        it 'Returns true when capturing an opponent\'s piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[2][0]
          spaces[3][5] = white_bishop
          spaces[2][0] = ' '

          expect(subject.check_legal_move([3, 5], [4, 6], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([2, 0], [3, 1], spaces)).to eql(false)
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

          black_pawn = spaces[2][6]
          spaces[2][4] = black_pawn
          spaces[2][6] = ' '

          expect(subject.check_legal_move([2, 7], [2, 5], spaces)).to eql(false)
        end

        it 'returns false when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[2][1]
          spaces[3][5] = white_pawn
          spaces[2][1] = ' '

          black_bishop = spaces[2][7]
          spaces[2][5] = black_bishop
          spaces[2][7] = ' '

          expect(subject.check_legal_move([2, 5], [3, 5], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns true when capturing diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_bishop = spaces[2][7]
          spaces[2][5] = black_bishop
          spaces[2][5] = ' '

          white_rook = spaces[0][0]
          spaces[3][4] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([2, 5], [3, 4], spaces)).to eql(true)
        end
      end

    end

  end
end

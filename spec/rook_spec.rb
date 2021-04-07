require './board_builder'

describe Rook do
  context 'color is white' do
    subject { Rook.new('white') }

    describe '#check_legal_move' do
      
      context 'When moving vertically' do
        it 'Returns true when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[2][0] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([2, 0], [5, 0], spaces)).to eql(true)
        end

        it 'Returns false moving vertically through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 0], [5, 0], spaces)).to eql(false)
        end

        it 'Returns true when capturing vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[2][0] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([2, 0], [6, 0], spaces)).to eql(true)
        end
      end
      
      context 'When moving horizontally' do
        it 'Returns true when moving horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[2][0] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([2, 0], [2, 7], spaces)).to eql(true)
        end

        it 'Returns false moving horizontally through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[2][0] = white_rook
          spaces[0][0] = ' '

          white_pawn = spaces[1][3]
          spaces[2][3] = white_pawn
          spaces[1][3] = ' '

          expect(subject.check_legal_move([2, 0], [2, 7], spaces)).to eql(false)
        end

        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[5][0] = white_rook
          spaces[0][0] = ' '

          black_pawn = spaces[6][2]
          spaces[5][2] = black_pawn
          spaces[6][2] = ' '

          expect(subject.check_legal_move([5, 0], [5, 2], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 0], [0, 1], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns false when moving diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[2][0] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([2, 0], [3, 1], spaces)).to eql(false)
        end
      end

    end

  end

  context 'color is black' do
    subject { Rook.new('black') }

    describe '#check_legal_move' do

      context 'When moving vertically' do
        it 'Returns true when capturing vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_rook = spaces[7][7]
          spaces[5][7] = black_rook
          spaces[7][7] = ' '

          expect(subject.check_legal_move([5, 7], [1, 7], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([7, 7], [6, 7], spaces)).to eql(false)
        end
      end
      
      context 'When moving horizontally' do
        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[0][2]
          spaces[2][2] = white_bishop
          spaces[0][2] = ' '

          black_rook = spaces[7][7]
          spaces[2][7] = black_rook
          spaces[7][7] = ' '

          expect(subject.check_legal_move([2, 7], [2, 2], spaces)).to eql(true)
        end
      end

      context 'When moving diagonally' do
        it 'Returns false when capturing one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([7, 7], [6, 6], spaces)).to eql(false)
        end
      end

    end
  end
end

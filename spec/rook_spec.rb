require './lib/board_builder'

describe Rook do
  context 'color is white' do
    subject { Rook.new('white') }

    describe '#check_legal_move' do
      
      context 'When moving vertically' do
        it 'Returns true when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][2] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([0, 2], [0, 5], spaces)).to eql(true)
        end

        it 'Returns false moving vertically through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 0], [0, 5], spaces)).to eql(false)
        end

        it 'Returns true when capturing vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][2] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([0, 2], [0, 6], spaces)).to eql(true)
        end
      end
      
      context 'When moving horizontally' do
        it 'Returns true when moving horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][2] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([0, 2], [7, 2], spaces)).to eql(true)
        end

        it 'Returns false moving horizontally through another piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][2] = white_rook
          spaces[0][0] = ' '

          white_pawn = spaces[3][1]
          spaces[3][2] = white_pawn
          spaces[3][1] = ' '

          expect(subject.check_legal_move([0, 2], [7, 2], spaces)).to eql(false)
        end

        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][5] = white_rook
          spaces[0][0] = ' '

          black_pawn = spaces[2][6]
          spaces[2][5] = black_pawn
          spaces[2][6] = ' '

          expect(subject.check_legal_move([0, 5], [2, 5], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 0], [1, 0], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns false when moving diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_rook = spaces[0][0]
          spaces[0][2] = white_rook
          spaces[0][0] = ' '

          expect(subject.check_legal_move([0, 2], [1, 3], spaces)).to eql(false)
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
          spaces[7][5] = black_rook
          spaces[7][7] = ' '

          expect(subject.check_legal_move([7, 5], [7, 1], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([7, 7], [7, 6], spaces)).to eql(false)
        end
      end
      
      context 'When moving horizontally' do
        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_bishop = spaces[2][0]
          spaces[2][2] = white_bishop
          spaces[2][0] = ' '

          black_rook = spaces[7][7]
          spaces[7][2] = black_rook
          spaces[7][7] = ' '

          expect(subject.check_legal_move([7, 2], [2, 2], spaces)).to eql(true)
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

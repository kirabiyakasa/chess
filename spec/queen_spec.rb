require './lib/board_builder'

describe Queen do
  context 'color is White' do
    subject { Queen.new('white') }

    describe '#check_legal_move' do

      context 'When moving vertically or horizontally.' do
        it 'Returns true when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[3][1] = ' '

          expect(subject.check_legal_move([3, 0], [3, 5], spaces)).to eql(true)
        end

        it 'Returns false when moving irregularly.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          8.times do |i|
            spaces[i][1] = ' '
          end

          expect(subject.check_legal_move([3, 0], [2, 3], spaces)).to eql(false)
        end

        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_queen = spaces[3][0]
          spaces[3][2] = white_queen
          spaces[3][0] = ' '

          black_queen = spaces[3][7]
          spaces[6][2] = black_queen
          spaces[3][7] = ' '

          expect(subject.check_legal_move([3, 2], [6, 2], spaces)).to eql(true)
        end
      end

      context 'When moving diagonally.' do
        it 'Returns true when moving diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[2][1]
          spaces[2][2] = white_pawn
          spaces[2][1] = ' '

          expect(subject.check_legal_move([3, 0], [0, 3], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([3, 0], [4, 1], spaces)).to eql(false)
        end
      end

    end

  end
end

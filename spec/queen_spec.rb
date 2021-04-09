require './board_builder'

require 'pry'

describe Queen do
  context 'color is White' do
    subject { Queen.new('white') }

    describe '#check_legal_move' do

      context 'When moving vertically or horizontally.' do
        it 'Returns true when moving vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          spaces[1][2] = ' '

          expect(subject.check_legal_move([0, 3], [3, 0], spaces)).to eql(true)
        end

        it 'Returns false when moving irregularly.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          8.times do |i|
            spaces[1][i] = ' '
          end

          expect(subject.check_legal_move([0, 3], [3, 2], spaces)).to eql(false)
        end

        it 'Returns true when capturing horizontally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_queen = spaces[0][3]
          spaces[2][3] = white_queen
          spaces[0][3] = ' '

          black_queen = spaces[7][3]
          spaces[2][6] = black_queen
          spaces[7][3] = ' '

          expect(subject.check_legal_move([2, 3], [2, 6], spaces)).to eql(true)
        end
      end

      context 'When moving diagonally.' do
        it 'Returns true when moving diagonally.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_pawn = spaces[1][2]
          spaces[2][2] = white_pawn
          spaces[1][2] = ' '

          expect(subject.check_legal_move([0, 3], [3, 0], spaces)).to eql(true)
        end

        it 'Returns false when capturing one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([0, 3], [1, 4], spaces)).to eql(false)
        end
      end

    end

  end
end

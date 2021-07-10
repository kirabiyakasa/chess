require './lib/board_builder'
require './lib/board'
require './lib/player'

describe King do
  context 'color is white' do
    subject { King.new('white') }

    describe '#checked?' do
      context 'When checked vertically' do
        it 'Returns true when checked by a rook.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_rook = spaces[0][7]
          spaces[4][5] = black_rook
          spaces[0][7] = ' '

          white_king = spaces[4][0]
          spaces[4][2] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 2], spaces)).to eql(true)
        end

        it 'Returns true when checked by a rook.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_rook = spaces[0][7]
          spaces[0][5] = black_rook
          spaces[0][7] = ' '

          white_king = spaces[4][0]
          spaces[0][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([0, 3], spaces)).to eql(true)
        end

        it 'Returns false when not checked.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_king = spaces[4][0]
          spaces[4][2] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 2], spaces)).to eql(false)
        end
      end

      context 'When checked horizontally' do
        it 'Returns true when checked by a rook.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_rook = spaces[0][7]
          spaces[0][3] = black_rook
          spaces[0][7] = ' '

          white_king = spaces[4][0]
          spaces[4][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 3], spaces)).to eql(true)
        end

        it 'Returns true when checked by a queen.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_queen = spaces[3][7]
          spaces[4][3] = black_queen
          spaces[3][7] = ' '

          white_king = spaces[4][0]
          spaces[1][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([1, 3], spaces)).to eql(true)
        end

        it 'Returns false when not in check.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_king = spaces[4][0]
          spaces[1][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([1, 3], spaces)).to eql(false)
        end
      end

      context 'When checked diagonally' do
        it 'Returns true when checked by a bishop.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_bishop = spaces[2][7]
          spaces[2][5] = black_bishop
          spaces[2][7] = ' '

          white_king = spaces[4][0]
          spaces[4][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 3], spaces)).to eql(true)
        end

        it 'Returns false when not checked.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_king = spaces[4][0]
          spaces[4][3] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 2], spaces)).to eql(false)
        end

        it 'Returns true when checked by a pawn.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_pawn = spaces[5][6]
          spaces[5][5] = black_pawn
          spaces[5][6] = ' '

          white_king = spaces[4][0]
          spaces[4][4] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 4], spaces)).to eql(true)
        end

        it 'Returns false when enemy pawn is facing away from king' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_pawn = spaces[5][6]
          spaces[5][3] = black_pawn
          spaces[5][6] = ' '

          white_king = spaces[4][0]
          spaces[4][4] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 4], spaces)).to eql(false)
        end

        it 'Returns false when targeted by one\'s own pawn.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_king = spaces[4][0]
          spaces[4][2] = white_king
          spaces[4][0] = ' '

          expect(subject.checked?([4, 2], spaces)).to eql(false)
        end
      end

      it 'Returns true when checked by a knight.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        black_knight = spaces[1][7]
        spaces[0][5] = black_knight
        spaces[1][7] = ' '

        white_king = spaces[4][0]
        spaces[2][4] = white_king
        spaces[4][0] = ' '

        expect(subject.checked?([2, 4], spaces)).to eql(true)
      end
    end

  end
end

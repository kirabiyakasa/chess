require './board_builder'

describe Knight do
  context 'color is white' do
    subject { Knight.new('white') }

    describe '#check_legal_move' do

      it 'Returns true when moving up twice and left once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([0, 1], [2, 0], spaces)).to eql(true)
      end

      it 'Returns true when moving up once and right twice.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        white_knight = spaces[0][1]
        spaces[2][1] = white_knight
        spaces[0][1] = ' '

        expect(subject.check_legal_move([2, 1], [3, 3], spaces)).to eql(true)
      end

      it 'Returns false when moving up once and right once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        white_knight = spaces[0][1]
        spaces[2][1] = white_knight
        spaces[0][1] = ' '

        expect(subject.check_legal_move([2, 1], [3, 2], spaces)).to eql(false)
      end

      it 'Returns false when moving up twice' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([0, 1], [2, 1], spaces)).to eql(false)
      end

      it 'Returns false when capturing one\'s own piece' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([0, 1], [1, 3], spaces)).to eql(false)
      end

    end

  end

  context 'color is black' do
    subject { Knight.new('black') }

    describe '#check_legal_move' do

      it 'Return true when moving down twice and right once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([7, 1], [5, 2], spaces)).to eql(true)
      end

      it 'Returns false when move down 3 times and left twice.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([7, 1], [4, 0], spaces)).to eql(false)
      end

      it 'Returns true when capturing opponent\'s piece.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        black_knight = spaces[7][1]
        spaces[2][1] = black_knight
        spaces[0][1] = ' '

        expect(subject.check_legal_move([2, 1], [1, 3], spaces)).to eql(true)
      end

    end

  end
end

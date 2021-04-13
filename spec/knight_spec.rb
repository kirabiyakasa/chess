require './board_builder'

describe Knight do
  context 'color is white' do
    subject { Knight.new('white') }

    describe '#check_legal_move' do

      it 'Returns true when moving up twice and left once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([1, 0], [0, 2], spaces)).to eql(true)
      end

      it 'Returns true when moving up once and right twice.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        white_knight = spaces[1][0]
        spaces[1][2] = white_knight
        spaces[1][0] = ' '

        expect(subject.check_legal_move([1, 2], [3, 3], spaces)).to eql(true)
      end

      it 'Returns false when moving up once and right once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        white_knight = spaces[1][0]
        spaces[1][2] = white_knight
        spaces[1][0] = ' '

        expect(subject.check_legal_move([1, 2], [2, 3], spaces)).to eql(false)
      end

      it 'Returns false when moving up twice' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([1, 0], [1, 2], spaces)).to eql(false)
      end

      it 'Returns false when capturing one\'s own piece' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([1, 0], [3, 1], spaces)).to eql(false)
      end

    end

  end

  context 'color is black' do
    subject { Knight.new('black') }

    describe '#check_legal_move' do

      it 'Return true when moving down twice and right once.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([1, 7], [2, 5], spaces)).to eql(true)
      end

      it 'Returns false when move down 3 times and left twice.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        expect(subject.check_legal_move([1, 7], [0, 4], spaces)).to eql(false)
      end

      it 'Returns true when capturing opponent\'s piece.' do
        board_builder = BoardBuilder.new
        spaces = board_builder.build_board

        black_knight = spaces[1][7]
        spaces[1][2] = black_knight
        spaces[1][7] = ' '

        expect(subject.check_legal_move([1, 2], [3, 1], spaces)).to eql(true)
      end

    end

  end
end

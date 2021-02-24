require './board_builder'
require './pieces/pawn'

describe Pawn do
  context 'color is white' do
    subject { Pawn.new('white') }

    describe '#check_legal_move' do

      context 'When moving vertically' do
        it 'Returns true if moving vertically once from it\'s starting 
        position.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([1, 2], [2, 2], spaces)).to eql(true)
        end

        it 'Returns true if moving twice from it\'s starting position.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([1, 2], [3, 2], spaces)).to eql(true)
        end

        it 'Returns false if moving twice after having already moved.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          subject.check_legal_move([1, 2], [2, 2], spaces)
          expect(subject.check_legal_move([2, 2], [4, 2], spaces)).to eql(false)
        end

        it 'Returns false if moving 3 or more times from it\'s starting 
        position.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([1, 2], [4, 2], spaces)).to eql(false)
        end

        it 'Returns false when trying to capture an opponent\'s piece 
        vertically.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece = spaces[1][2]
          spaces[3][2] = white_piece
          spaces[1][2] = ' '

          black_piece = spaces[6][2]
          spaces[4][2] = black_piece
          spaces[6][2] = ' '

          expect(subject.check_legal_move([3, 2], [4, 2], spaces)).to eql(false)
        end

      end

      context 'When moving diagonally' do
        it 'Returns false if moving diagonally without capturing opponent\'s 
        piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board
            
          expect(subject.check_legal_move([1, 2], [2, 1], spaces)).to eql(false)
        end

        it 'Returns true if moving diagonally while capturing opponent\'s 
        piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece = spaces[1][2]
          spaces[3][2] = white_piece
          spaces[1][2] = ' '

          black_piece = spaces[6][3]
          spaces[4][3] = black_piece
          spaces[6][2] = ' '

          expect(subject.check_legal_move([3, 2], [4, 3], spaces)).to eql(true)
        end

        it 'Returns false if attempting to capture one\'s own piece' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece2 = spaces[1][3]
          spaces[2][3] = white_piece2
          spaces[1][3] = ' '

          expect(subject.check_legal_move([1, 2], [2, 3], spaces)).to eql(false)
        end

      end

      context 'When attempting en passant' do

        it 'Returns true when capturing opponent\'s piece via en passant.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece = spaces[1][2]
          spaces[4][2] = white_piece
          spaces[1][2] = ' '

          black_piece = spaces[6][3]
          black_piece.check_legal_move([6, 3], [4, 3], spaces)
          spaces[4][3] = black_piece
          spaces[6][3] = ' '

          expect(subject.check_legal_move([4, 2], [5, 3], spaces)).to eql(true)
        end

        it 'Returns false when trying to capture via en passant without the 
        opposing piece having moved two spaces in one turn.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece = spaces[1][2]
          spaces[4][2] = white_piece
          spaces[1][2] = ' '

          black_piece = spaces[6][3]
          black_piece.check_legal_move([6, 3], [5, 3], spaces)
          spaces[5][3] = black_piece
          spaces[6][3] = ' '

          black_piece.check_legal_move([5, 3], [4, 3], spaces)
          spaces[4][3] = black_piece
          spaces[5][3] = ' '

          expect(subject.check_legal_move([4, 2], [5, 3], spaces)).to eql(false)
        end

        it 'Returns false when trying to capture one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece1 = spaces[1][2]
          spaces[3][2] = white_piece1
          spaces[1][2] = ' '

          white_piece2 = spaces[1][3]
          white_piece2.check_legal_move([1, 3], [3, 3], spaces)
          spaces[3][3] = white_piece2
          spaces[1][3] = ' '

          expect(subject.check_legal_move([3, 2], [4, 3], spaces)).to eql(false)
        end

      end

      context 'When making miscellaneous illegal moves' do
        it 'Returns false when moving to a random space on the other side of 
        the board.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([1, 2], [6, 0], spaces)).to eql(false)
        end

        it 'Returns false when moving onto one\'s own piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece2 = spaces[1][3]
          spaces[2][3] = white_piece2
          spaces[1][3] = ' '

          expect(subject.check_legal_move([1, 2], [2, 3], spaces)).to eql(false)
        end
      end

    end

  end

  context 'color is black' do
    subject { Pawn.new('black') }

    describe '#check_legal_move' do
      context 'When moving vertically' do
        it 'Returns true if moving vertically once from it\'s starting 
        position.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([6, 2], [5, 2], spaces)).to eql(true)
        end

        it 'Returns false if moving 3 or more times from it\'s starting 
        position.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([6, 2], [3, 2], spaces)).to eql(false)
        end
      end

      context 'When moving diagonally' do
        it 'Returns false if moving diagonally without capturing opponent\'s 
        piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([6, 2], [5, 1], spaces)).to eql(false)
        end

        it 'Returns true if moving diagonally while capturing opponent\'s 
        piece.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          white_piece = spaces[1][1]
          spaces[5][1] = white_piece
          spaces[1][1] = ' '

          expect(subject.check_legal_move([6, 2], [5, 1], spaces)).to eql(true)
        end
      end

      context 'When attempting en passant' do
        it 'Returns true when capturing opponent\'s piece via en passant.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_piece = spaces[6][2]
          spaces[3][2] = black_piece
          spaces[6][2] = ' '

          white_piece = spaces[1][1]
          white_piece.check_legal_move([1, 1], [3, 1], spaces)
          spaces[3][1] = white_piece
          spaces[1][1] = ' '

          expect(subject.check_legal_move([3, 2], [2, 1], spaces)).to eql(true)
        end

        it 'Returns false when trying to capture via en passant without the 
        opposing piece having moved two spaces in one turn.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          black_piece = spaces[6][2]
          spaces[3][2] = black_piece
          spaces[6][2] = ' '

          white_piece = spaces[1][1]
          white_piece.check_legal_move([1, 1], [2, 1], spaces)
          spaces[2][1] = white_piece
          spaces[1][1] = ' '

          white_piece.check_legal_move([2, 1], [3, 1], spaces)
          spaces[3][1] = white_piece
          spaces[2][1] = ' '

          expect(subject.check_legal_move([3, 2], [2, 1], spaces)).to eql(false)
        end
      end

      context 'When making miscellaneous illegal moves' do
        it 'Returns false when moving to a random space on the other side of 
        the board.' do
          board_builder = BoardBuilder.new
          spaces = board_builder.build_board

          expect(subject.check_legal_move([6, 2], [0, 5], spaces)).to eql(false)
        end
      end

    end
  end

end

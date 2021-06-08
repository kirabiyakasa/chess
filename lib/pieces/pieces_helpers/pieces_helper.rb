require 'pry'

module PiecesHelper

  def check_legal_move(start_coords, end_coords, spaces)
    rank = end_coords[0]
    file = end_coords[1]
    space = spaces[rank][file]

    move_validity = validate_move(start_coords, end_coords, spaces, space)
    return move_validity
  end

  def get_moves()
    moves = { 
      :bishop_moves => [[-1, 1], [1, 1], [1, -1], [-1, -1]],
      :rook_moves => [[0, 1], [1, 0], [0, -1], [-1, 0]],
      :king_moves => [
        [-1, 1], [0, 1], [1, 1], [1, 0],
        [1, -1], [0, -1], [-1, -1], [-1, 0]
      ],
      :knight_moves => [
        [-2, 1], [-1, 2], [2, 1], [1, 2],
        [-2, -1], [-1, -2], [2, -1], [1, -2]
      ]
    }

    if @color == 'black'
      moves[:pawn_moves] = [[-1, 1], [0, 1], [1, 1]]
    else
      moves[:pawn_moves] = [[-1, -1], [0, -1], [1, -1]]
    end
    return moves
  end

  private

  def capture(spaces, capture_coords)
    rank = capture_coords[0]
    file = capture_coords[1]
    spaces[rank].slice!(file)
    spaces[rank].insert(file, ' ')
  end

end

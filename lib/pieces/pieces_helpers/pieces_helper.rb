require 'pry'

module PiecesHelper

  def check_legal_move(start_coords, end_coords, spaces)
    rank = end_coords[0]
    file = end_coords[1]
    space = spaces[rank][file]

    move_validity = validate_move(start_coords, end_coords, spaces, space)
    return move_validity
  end

  private

  def capture(spaces, capture_coords)
    rank = capture_coords[0]
    file = capture_coords[1]
    spaces[rank].slice!(file)
    spaces[rank].insert(file, ' ')
  end

end

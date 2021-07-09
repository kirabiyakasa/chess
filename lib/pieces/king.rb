require './lib/pieces/pieces_helpers/king_helpers/king_helper'
require './lib/pieces/pieces_helpers/king_helpers/check_helper'
require './lib/pieces/pieces_helpers/king_helpers/checkmate_helper'
require './lib/pieces/pieces_helpers/king_helpers/stalemate_helper.rb'

class King
  include PiecesHelper
  include KingHelper
  include CheckHelper
  include CheckmateHelper
  include StalemateHelper

  attr_reader :color, :icon, :moved

  def initialize(color)
    @color = color
    @icon = get_icon()
    @moved = false
    @checked_by = []
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    file = end_coords[0] - start_coords[0]
    rank = end_coords[1] - start_coords[1]
    coord_change = [file, rank]
    capture_coords = [end_coords[0], end_coords[1]]

    if king_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def get_icon()
    if @color == 'white'
      return '♔'
    elsif @color == 'black'
      return '♚'
    end
  end

end

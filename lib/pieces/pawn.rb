require './lib/pieces/pieces_helpers/pawn_helper'

require 'pry'

class Pawn
  include PiecesHelper
  include PawnHelper

  attr_reader :en_passant, :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
    @en_passant = false
    @moved = false
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    file = end_coords[0] - start_coords[0]
    rank = end_coords[1] - start_coords[1]
    coord_change = [file, rank]
    capture_coords = [end_coords[0], end_coords[1]]

    if space == ' '
      if vertical_movement?(coord_change, end_coords, spaces)
        return true
      elsif en_passant?(start_coords, coord_change, end_coords, spaces)
        capture(spaces, [end_coords[0] - 1, end_coords[1]])
        return true
      end
    elsif diagonal_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def get_icon()
    if @color == 'white'
      @icon = '♙'
    elsif @color == 'black'
      @icon = '♟︎'
    end
  end

end

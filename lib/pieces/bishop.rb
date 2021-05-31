require './lib/pieces/pieces_helpers/bishop_helper'

require 'pry'

class Bishop
  include PiecesHelper
  include BishopHelper

  attr_reader :color, :icon
  
  def initialize(color)
    @color = color
    @icon = get_icon()
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    file = end_coords[0] - start_coords[0]
    rank = end_coords[1] - start_coords[1]
    coord_change = [file, rank]
    capture_coords = [end_coords[0], end_coords[1]]

    if diagonal_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def get_icon()
    if @color == 'white'
      @icon = '♗'
    elsif @color == 'black'
      @icon = '♝'
    end
  end

end

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

  attr_reader :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
    @checked_by = []
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
  end

  def get_icon()
    if @color == 'white'
      return '♔'
    elsif @color == 'black'
      return '♚'
    end
  end

end

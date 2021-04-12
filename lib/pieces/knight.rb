class Knight
  include PiecesHelper

  attr_reader :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
    @move_list =
    [
      [-2, 1], [-1, 2], [2, 1], [1, 2],
      [-2, -1], [-1, -2], [2, -1], [1, -2]
    ]
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    rank = end_coords[0] - start_coords[0]
    file = end_coords[1] - start_coords[1]
    coord_change = [rank, file]
    capture_coords = [end_coords[0], end_coords[1]]

    if knight_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def knight_movement?(start_coords, coord_change, end_coords, spaces)
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end

    if @move_list.include?(coord_change)
      return true
    end
    return false
  end

  def get_icon()
    if @color == 'white'
      @icon = '♘'
    elsif @color == 'black'
      @icon = '♞'
    end
  end

end

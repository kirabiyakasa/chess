require 'pry'

class Rook
  include PiecesHelper

  attr_reader :color, :icon

  def initialize(color)
    @color = color
    @icon = get_icon()
  end

  private

  def validate_move(start_coords, end_coords, spaces, space)
    x = end_coords[0] - start_coords[0]
    y = end_coords[1] - start_coords[1]
    coord_change = [x, y]
    capture_coords = [end_coords[0], end_coords[1]]

    if vertical_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    elsif horizontal_movement?(start_coords, coord_change, end_coords, spaces)
      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def vertical_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[0] == 0
    unless coord_change[1] == 0
      return false
    end

    coord_change[0].positive? ? direction = [1, 0] : direction = [-1, 0]

    path = get_moves(direction, start_coords, end_coords, spaces)
    return false if path.empty?

    destination = path.pop
    unless destination == ' '
      return false if destination.color == @color
    end

    path.each do |space|
      if space != ' '
        return false
      end
    end
    return true
  end

  def horizontal_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[1] == 0
    unless coord_change[0] == 0
      return false
    end

    coord_change[1].positive? ? direction = [0, 1] : direction = [0, -1]

    path = get_moves(direction, start_coords, end_coords, spaces)
    return false if path.empty?

    destination = path.pop
    unless destination == ' '
      return false if destination.color == @color
    end

    path.each do |space|
      if space != ' '
        return false
      end
    end
    return true
  end

  def get_moves(direction, start_coords, end_coords, spaces)
    path = []
    rank = start_coords[0]
    file = start_coords[1]
    
    until rank == end_coords[0] && file == end_coords[1]
      rank += direction[0]
      file += direction[1]
      path << spaces[rank][file]
    end
    return path
  end

  def get_icon()
    if @color == 'white'
      @icon = '♖'
    elsif @color == 'black'
      @icon = '♜'
    end
  end

end

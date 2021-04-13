require 'pry'

class Queen
  include PiecesHelper

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

    if diagonal_movement?(start_coords, coord_change, end_coords, spaces) ||
       vertical_movement?(start_coords, coord_change, end_coords, spaces) ||
       horizontal_movement?(start_coords, coord_change, end_coords, spaces)

      capture(spaces, capture_coords)
      return true
    end
    return false
  end

  def diagonal_movement?(start_coords, coord_change, end_coords, spaces)
    unless coord_change[0].abs == coord_change[1].abs
      return false
    end

    direction = []
    coord_change[0].positive? ? direction << 1 : direction << -1
    coord_change[1].positive? ? direction << 1 : direction << -1
    path = get_diagonal_moves(direction, start_coords, end_coords, spaces)
    
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
  
  def get_diagonal_moves(direction, start_coords, end_coords, spaces)
    path = []
    file = start_coords[0]
    rank = start_coords[1]
  
    until file == end_coords[0] && rank == end_coords[1]
      file += direction[0]
      rank += direction[1]
      path << spaces[file][rank]
    end
    return path
  end

  def vertical_movement?(start_coords, coord_change, end_coords, spaces)
    return false if coord_change[1] == 0
    unless coord_change[0] == 0
      return false
    end

    coord_change[1].positive? ? direction = [0, 1] : direction = [0, -1]

    path = get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
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
    return false if coord_change[0] == 0
    unless coord_change[1] == 0
      return false
    end

    coord_change[0].positive? ? direction = [1, 0] : direction = [-1, 0]

    path = get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
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

  def get_horiz_vert_moves(direction, start_coords, end_coords, spaces)
    path = []
    file = start_coords[0]
    rank = start_coords[1]
    
    until file == end_coords[0] && rank == end_coords[1]
      file += direction[0]
      rank += direction[1]
      path << spaces[file][rank]
    end
    return path
  end

  def get_icon()
    if @color == 'white'
      @icon = '♕'
    elsif @color == 'black'
      @icon = '♛'
    end
  end

end

require 'pry'

module BishopHelper

  def get_diagonal_moves(coord_change, start_coords, end_coords, spaces)
    direction = []
    coord_change[0].positive? ? direction << 1 : direction << -1
    coord_change[1].positive? ? direction << 1 : direction << -1

    path = []
    file = start_coords[0]
    rank = start_coords[1]

    until file == end_coords[0] && rank == end_coords[1]
      file += direction[0]
      rank += direction[1]
      path << [file, rank]
    end
    return path
  end

  private

  def diagonal_movement?(start_coords, coord_change, end_coords, spaces)
    unless coord_change[0].abs == coord_change[1].abs
      return false
    end

    path = get_diagonal_moves(coord_change, start_coords, end_coords, spaces)
  
    return false if path.empty?
  
    path.pop
    destination = spaces[end_coords[0]][end_coords[1]]
    unless destination == ' '
      return false if destination.color == @color
    end
  
    path.each do |coords|
      if spaces[coords[0]][coords[1]] != ' '
        return false
      end
    end
    return true
  end

end
